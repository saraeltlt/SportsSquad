//
//  APIHandler.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 19/05/2023.
//

import Foundation
import Alamofire
class NetworkManeger : NetworkManegerProtocol{
    
    static var sharedInstance = NetworkManeger()
    static var todayString: String!
    static var yesterdayString: String!

    private init() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        if let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) {
            NetworkManeger.yesterdayString = dateFormatter.string(from: yesterday)
        }
        NetworkManeger.todayString = dateFormatter.string(from: Date())

    }
    static func getInstance() -> NetworkManeger{
        return sharedInstance
    }
    func getLeagues(sportType: String, completionHandler: @escaping (Result<LeaguesModel, Error>) -> Void) {
        let url = "\(K.BASIC_URL)\(sportType)/?met=Leagues&APIkey=\(K.API_KEY)"
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { response in
            switch response.result {
            case .success(let data):
                do {
                    let jsonData = try JSONDecoder().decode(LeaguesModel.self, from: data!)
                    completionHandler(.success(jsonData))
                } catch {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

    
    func getUpComingEvents(sportType: String, leagueId: Int, completionHandler: @escaping (Result<EventsModel, Error>) -> Void) {
        let url = "\(K.BASIC_URL)\(sportType)/?met=Fixtures&leagueId=\(leagueId)&from=\(NetworkManeger.todayString!)&to=2025-01-01&APIkey=\(K.API_KEY)"
        print("upcoming events -> \(url) \n")
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { response in
            switch response.result {
            case .success(let data):
                do {
                    let jsonData = try JSONDecoder().decode(EventsModel.self, from: data!)
                    completionHandler(.success(jsonData))
                } catch {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    
    func getLatestEvents(sportType: String, leagueId: Int, completionHandler: @escaping (Result<EventsModel, Error>) -> Void) {
        let url = "\(K.BASIC_URL)\(sportType)/?met=Fixtures&APIkey=\(K.API_KEY)&from=2022-8-01&to=\(NetworkManeger.yesterdayString!)&leagueId=\(leagueId)"
        print("latest events -> \(url) \n")
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { response in
            switch response.result {
            case .success(let data):
                do {
                    let jsonData = try JSONDecoder().decode(EventsModel.self, from: data!)
                    completionHandler(.success(jsonData))
                } catch {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

    func getTeams(sportType: String, leagueId: Int, completionHandler: @escaping (Result<TeamsModel, Error>) -> Void) {
        let url = "\(K.BASIC_URL)\(sportType)/?met=Teams&?met=Leagues&leagueId=\(leagueId)&APIkey=\(K.API_KEY)"
        print("teams -> \(url) \n")
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { response in
            switch response.result {
            case .success(let data):
                do {
                    let jsonData = try JSONDecoder().decode(TeamsModel.self, from: data!)
                    completionHandler(.success(jsonData))
                } catch {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    
    
    func getTennisPlayers(sportType: String, leagueId: Int, completionHandler: @escaping (Result<TeamsModel, Error>) -> Void) {
        let url = "\(K.BASIC_URL)\(sportType)/?met=Fixtures&leagueId=\(leagueId)&from=2021-01-23&to=2023-12-30&APIkey=\(K.API_KEY)"
        print("- tennis players -> \(url) \n")
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { response in
            switch response.result {
            case .success(let data):
                do {
                    let jsonData = try JSONDecoder().decode(TeamsModel.self, from: data!)
                    completionHandler(.success(jsonData))
                } catch {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    func getTeamDetails(teamId: Int, completionHandler: @escaping (Result<TeamsModel, Error>) -> Void) {
        let url = "\(K.BASIC_URL)football/?&met=Teams&teamId=\(teamId)&APIkey=\(K.API_KEY)"
        print("team details -> \(url) \n")
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { response in
            switch response.result {
            case .success(let data):
                do {
                    let jsonData = try JSONDecoder().decode(TeamsModel.self, from: data!)
                    completionHandler(.success(jsonData))
                } catch {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    
}

