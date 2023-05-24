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
    
    var  event_time : String?
    
    //footBall & basekt & tennis
    var event_date : String?
    //cricket
    var event_date_stop : String?
    
    //footBall & basekt &cricket
    var  event_home_team : String?
    var  event_away_team : String?
    
    // teniss
    var event_first_player: String?
    var event_second_player: String?
    
    var event_first_player_logo: String?
    var event_second_player_logo: String?
    
    //football
    var  home_team_logo : String?
    var  away_team_logo: String?
    
    //basket && cricket
    var event_home_team_logo: String?
    var event_away_team_logo: String?
    
    
    //footBall & basekt && Tenis
    var  event_final_result : String?
    //cricket
    var event_home_final_result : String?
    var event_away_final_result : String?
    
    
 
    
  
    

    
  
}
