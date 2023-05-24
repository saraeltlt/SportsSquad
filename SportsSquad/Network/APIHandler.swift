//
//  APIHandler.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 19/05/2023.
//

import Foundation
import Alamofire
class APIHandler : APIHandlerProtocol{
    
    
  
    static let sharedInstance = APIHandler()
    private init(){
        
    }
    static func getInstance() -> APIHandler{
        return sharedInstance
    }
    func getLeagues(sportType: String , completionHandler : @escaping(_ leagues:LeaguesModel)  -> (Void) ) {
        let url = "\(K.BASIC_URL)\(sportType)/?met=Leagues&APIkey=\(K.API_KEY)"
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default , headers: nil, interceptor: nil).response{ response in
            switch response.result{
            case .success(let data): do{
               let jsonData = try JSONDecoder().decode(LeaguesModel.self, from: data!)
                completionHandler(jsonData)
            }catch{
                print(error)
            }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getUpComingEvents(sportType: String ,leagueId: Int, completionHandler : @escaping(_ UpComingEvents:EventsModel)  -> (Void) ) {
        
        
        let url = "\(K.BASIC_URL)\(sportType)/?met=Fixtures&leagueId=\(leagueId)&from=2023-05-02&to=2024-06-02&APIkey=\(K.API_KEY)"
       // print(url)
  
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default , headers: nil, interceptor: nil).response{ response in
            switch response.result{
            case .success(let data): do{
               let jsonData = try JSONDecoder().decode(EventsModel.self, from: data!)
      
                completionHandler(jsonData)
            }catch{
                print(error)
            }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
     func getLatestEvents(sportType: String, leagueId: Int, completionHandler: @escaping (EventsModel) -> Void) {
         let url = "\(K.BASIC_URL)\(sportType)/?met=Fixtures&APIkey=\(K.API_KEY)&from=2022-01-23&to=2023-12-30&leagueId=\(leagueId)"
       //  print(url)
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default , headers: nil, interceptor: nil).response{ response in
            switch response.result{
            case .success(let data): do{
               let jsonData = try JSONDecoder().decode(EventsModel.self, from: data!)
                completionHandler(jsonData)
            }catch{
                print(error)
            }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
     func getTeams(sportType: String, leagueId: Int, completionHandler: @escaping (TeamsModel) -> Void) {
        let url = "\(K.BASIC_URL)\(sportType)/?met=Teams&?met=Leagues&leagueId=\(leagueId)&APIkey=\(K.API_KEY)"
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default , headers: nil, interceptor: nil).response{ response in
            switch response.result{
            case .success(let data): do{
                print("Data recived TEAMS")
                    let jsonData = try JSONDecoder().decode(TeamsModel.self, from: data!)
            
                    completionHandler(jsonData)
                
             
            }catch{
                print(error)
            }
            case .failure(let error):
                print(error)
            }
        }
    }
    func getTennisPlayers(sportType: String, leagueId: Int, completionHandler: @escaping (TeamsModel) -> Void) {
        let url = "\(K.BASIC_URL)\(sportType)/?met=Fixtures&leagueId=\(leagueId)&from=2021-01-23&to=2023-12-30&APIkey=\(K.API_KEY)"
        print(url)
       AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default , headers: nil, interceptor: nil).response{ response in
           switch response.result{
           case .success(let data): do{
    
                   let jsonData = try JSONDecoder().decode(TeamsModel.self, from: data!)
                   completionHandler(jsonData)

           }catch{
               print(error)
           }
           case .failure(let error):
               print(error)
           }
       }
   }
     func getTeamDetails( teamId: Int, completionHandler: @escaping (TeamsModel) -> Void) {
         let url = "\(K.BASIC_URL)football/?&met=Teams&teamId=\(teamId)&APIkey=\(K.API_KEY)"
         AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default , headers: nil, interceptor: nil).response{ response in
             switch response.result{
             case .success(let data): do{
                     let jsonData = try JSONDecoder().decode(TeamsModel.self, from: data!)
                 
                     completionHandler(jsonData)
             }catch{
                 print(error)
             }
             case .failure(let error):
                 print(error)
             }
         }
    }
    
    
}

