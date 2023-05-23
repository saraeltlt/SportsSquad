//
//  UpComingModel.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 19/05/2023.
//

import Foundation
class UpComingModel : Decodable {
    var result : [UpCommingEvent]
    var success : Int?
}
class UpCommingEvent : Decodable{
    var event_date : String?
    var event_time: String?
    
    //tennis
    var event_first_player: String?
    var event_first_player_logo: String?
    var event_second_player: String?
    var event_second_player_logo: String?
    
    
    //football && basket && cricket
    var event_home_team : String?
    var event_away_team : String?
    
    //football
    var home_team_logo : String?
    var away_team_logo : String?
    //basket && cricket
    var event_home_team_logo: String?
    var event_away_team_logo: String?
    
    
    
    
    
}
