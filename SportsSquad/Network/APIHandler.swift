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
                print("Data recived")
               let jsonData = try JSONDecoder().decode(LeaguesModel.self, from: data!)
                completionHandler(jsonData)
            }catch{
                print(error.localizedDescription)
            }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getUpComingEvents(sportType: String ,leagueId: Int, completionHandler : @escaping(_ UpComingEvents:UpComingModel)  -> (Void) ) {
        
        
        let url = "\(K.BASIC_URL)\(sportType)/?met=Fixtures&leagueId=\(leagueId)&from=2023-05-09&to=2024-02-09&APIkey=\(K.API_KEY)"

        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default , headers: nil, interceptor: nil).response{ response in
            switch response.result{
            case .success(let data): do{
                print("Data recived")
               let jsonData = try JSONDecoder().decode(UpComingModel.self, from: data!)
                completionHandler(jsonData)
            }catch{
                print(error.localizedDescription)
            }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    static func getLatestEvents(sportType: String, leagueId: Int, completionHandler: @escaping (LatestEventModel?) -> Void) {
        
        let url = "\(K.BASIC_URL)\(sportType)/?met=Livescore&leagueId=\(leagueId)&APIkey=\(K.API_KEY)"


        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default , headers: nil, interceptor: nil).response{ response in
            switch response.result{
            case .success(let data): do{
                print("Data recived")
               let jsonData = try JSONDecoder().decode(LatestEventModel.self, from: data!)
                completionHandler(jsonData)
            }catch{
                print(error.localizedDescription)
            }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    
}
