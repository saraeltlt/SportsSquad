//
//  MockNetworkManager.swift
//  SportsSquadTests
//
//  Created by Sara Eltlt on 29/05/2023.
//

import Foundation
@testable import SportsSquad

class MockNetworkManager: NetworkManegerProtocol, Mockable {
    
    enum ResponseType {
        case leagues
        case event
        case team
    }
    
    var shouldReturnError: Bool
    var responseType: ResponseType
    
    init(shouldReturnError: Bool, responseType: ResponseType) {
        self.shouldReturnError = shouldReturnError
        self.responseType = responseType
    }
    
    func getApiData<T>(url: String, completionHandler: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        do {
            if shouldReturnError {
                let jsonData = try loadJSON(filename: "INVALID_NAME", type: EventsModel.self)
                completionHandler(.success(jsonData as! T))
            } else {
                switch responseType {
                case .leagues:
                    let jsonData = try loadJSON(filename: "LeaguesResponse", type: LeaguesModel.self)
                    completionHandler(.success(jsonData as! T))
                    
                case .event:
                    let jsonData = try loadJSON(filename: "EventResponse", type: EventsModel.self)
                    completionHandler(.success(jsonData as! T))
                    
                case .team:
                    let jsonData = try loadJSON(filename: "TeamResponse", type: TeamsModel.self)
                    completionHandler(.success(jsonData as! T))
                }
            }
        } catch MockableError.failedToDecodeJSON {
            completionHandler(.failure(MockableError.failedToDecodeJSON))
        } catch {
            completionHandler(.failure(MockableError.failedToLoadJSON))
        }
    }
}
