import XCTest
@testable import SportsSquad

class MockNetworkManagerTests: XCTestCase {
    
    var networkManager: NetworkManegerProtocol?
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        networkManager = nil
    }
    
    // MARK: -  leagues response
    func testGetDataLeaguesResponse_ShouldPass() {
        networkManager = MockNetworkManager(shouldReturnError: false, responseType: .leagues)
        networkManager?.getApiData(url: "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=c0bddea4fa8a6125d9d6a00001e9ecd71e7107a99aeef4d1154c551d2feb96e8") { (result: Result<LeaguesModel, Error>) in
            switch result {
            case .success(let items):
                XCTAssertGreaterThan(items.result?.count ?? 0, 0, "Error decoding data")
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }
        }
    }
    
    // MARK: - Event response
    
    func testGetDataEventResponse_ShouldPass() {
        networkManager = MockNetworkManager(shouldReturnError: false, responseType: .event)
        networkManager?.getApiData(url: "https://apiv2.allsportsapi.com/football/?met=Teams&?met=Leagues&leagueId=152&APIkey=c0bddea4fa8a6125d9d6a00001e9ecd71e7107a99aeef4d1154c551d2feb96e8") { (result: Result<EventsModel, Error>) in
            switch result {
            case .success(let items):
                XCTAssertGreaterThan(items.result?.count ?? 0, 0, "Error decoding data")
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }
        }
    }
    
    // MARK: - teams response
    
    func testGetDataTeamResponse_ShouldPass() {
        networkManager = MockNetworkManager(shouldReturnError: false, responseType: .team)
        networkManager?.getApiData(url: "https://apiv2.allsportsapi.com/football/?&met=Teams&teamId=74&APIkey=c0bddea4fa8a6125d9d6a00001e9ecd71e7107a99aeef4d1154c551d2feb96e8") { (result: Result<TeamsModel, Error>) in
            switch result {
            case .success(let items):
                XCTAssertGreaterThan(items.result?.count ?? 0, 0, "Error decoding data")
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }
        }
    }
    
    // MARK: - fail
    
    func testGetData_ShouldFail() {
        networkManager = MockNetworkManager(shouldReturnError: true, responseType: .event)
        networkManager?.getApiData(url: "https://apiv2.allsportsapi.com/football/?met=Teams&?met=Leagues&leagueId=152&APIkey=c0bddea4fa8a6125d9d6a00001e9ecd71e7107a99aeef4d1154c551d2feb96e8") { (result: Result<EventsModel, Error>) in
            switch result {
            case .success(let items):
                XCTFail("Unexpected success: \(items)")
            case .failure(let error):
                XCTAssertNotNil(error, "Error should not be nil")
            }
        }
    }
}
