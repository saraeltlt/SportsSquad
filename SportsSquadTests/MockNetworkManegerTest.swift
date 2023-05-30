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
        networkManager?.getApiData(url: "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=097bcb5d95f937c824bc73356efa4f56d12446d32e8245d2ad36950c16294ab7") { (result: Result<LeaguesModel, Error>) in
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
        networkManager?.getApiData(url: "https://apiv2.allsportsapi.com/football/?met=Teams&?met=Leagues&leagueId=152&APIkey=097bcb5d95f937c824bc73356efa4f56d12446d32e8245d2ad36950c16294ab7") { (result: Result<EventsModel, Error>) in
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
        networkManager?.getApiData(url: "https://apiv2.allsportsapi.com/football/?&met=Teams&teamId=74&APIkey=097bcb5d95f937c824bc73356efa4f56d12446d32e8245d2ad36950c16294ab7") { (result: Result<TeamsModel, Error>) in
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
        networkManager?.getApiData(url: "https://apiv2.allsportsapi.com/football/?met=Teams&?met=Leagues&leagueId=152&APIkey=097bcb5d95f937c824bc73356efa4f56d12446d32e8245d2ad36950c16294ab7") { (result: Result<EventsModel, Error>) in
            switch result {
            case .success(let items):
                XCTFail("Unexpected success: \(items)")
            case .failure(let error):
                XCTAssertNotNil(error, "Error should not be nil")
            }
        }
    }
}
