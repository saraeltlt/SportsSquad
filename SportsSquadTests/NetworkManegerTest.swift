//
//  SportsSquadTests.swift
//  SportsSquadTests
//
//  Created by Sara Eltlt on 18/05/2023.
//

import XCTest
@testable import SportsSquad

class NetworkManegerTest: XCTestCase {
    
    var networkManager : NetworkManegerProtocol!
    
    override func setUpWithError() throws {
        networkManager = NetworkManeger.shared
        
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
        networkManager = nil
    }
    
    //MARK: - should pass
    
    func testGetApiData_ShouldPass() {
        let url = "https://apiv2.allsportsapi.com/football/?met=Fixtures&leagueId=3&from=2023-05-30&to=2025-01-01&APIkey=c0bddea4fa8a6125d9d6a00001e9ecd71e7107a99aeef4d1154c551d2feb96e8"
        let expectation = self.expectation(description: "API response")
        
        networkManager.getApiData(url: url) { (result: Result<EventsModel, Error>) in
            switch result {
            case .success(let leaguesModel):
                XCTAssertGreaterThan(leaguesModel.result?.count ?? 0 , 0, "Error: Empty response")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }
    
    //MARK: - should fail
    
    func testGetApiData_ShouldFail() {
        let url = "INVALId_URL"
        let expectation = self.expectation(description: "API response")
        
        networkManager.getApiData(url: url) { (result: Result<EventsModel, Error>) in
            switch result {
            case .success:
                XCTFail("Unexpected success: API should fail")
            case .failure(let error):
                XCTAssertNotNil(error, "Error should not be nil")
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }
}








