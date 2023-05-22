//
//  LatestEventModel.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 19/05/2023.
//

import Foundation
class LatestEventModel : Decodable {
    var success : Int?
    var result : [LatestEvents]
}
class LatestEvents : Decodable {
    var  event_date : String?
    var  event_time : String?
    var  event_home_team : String?
    var  event_away_team : String?
    var  event_final_result : String?
    var  home_team_logo : String?
    var  away_team_logo: String?
  
    
  
}
