//
//  LatestEventModel.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 19/05/2023.
//

import Foundation
class EventsModel : Decodable {
    var success : Int?
    var result : [Event]?
}
class Event : Decodable {
    //time ->
    var  event_time : String?
    
    //date->
    
    //footBall & basekt & tennis
    var event_date : String?
    //cricket
    var event_date_stop : String?
    
    
    //name->
    
    //footBall & basekt &cricket
    var  event_home_team : String?
    var  event_away_team : String?
    // teniss
    var event_first_player: String?
    var event_second_player: String?
    
    
    //logo->
    
    //football
    var  home_team_logo : String?
    var  away_team_logo: String?
    
    //basket && cricket
    var event_home_team_logo: String?
    var event_away_team_logo: String?
    
    // teniss
    var event_first_player_logo: String?
    var event_second_player_logo: String?
    
   
    //result
    
    //footBall & basekt && Tennis
    var  event_final_result : String?
    //cricket
    var event_home_final_result : String?
    var event_away_final_result : String?
    
}
//MARK: - struct to upcoming View

struct UpComingStructView {
  
    var  event_time : String?
    var event_date : String?
    var  event_home_team : String?
    var  event_away_team : String?
    var  home_team_logo : String?
    var  away_team_logo: String?
    
    init (sportType: String, event: Event){
        switch sportType{
            
        case K.sportsType.football.rawValue:
            self.event_time = event.event_time
            self.event_date = event.event_date
            self.event_home_team = event.event_home_team
            self.event_away_team = event.event_away_team
            self.home_team_logo =  event.home_team_logo
            self.away_team_logo = event.away_team_logo
      
            
        case K.sportsType.cricket.rawValue:
            self.event_time = event.event_time
            self.event_date = event.event_date_stop
            self.event_home_team = event.event_home_team
            self.event_away_team = event.event_away_team
            self.home_team_logo =  event.event_home_team_logo
            self.away_team_logo = event.event_away_team_logo
            
        case K.sportsType.basketball.rawValue:
            self.event_time = event.event_time
            self.event_date = event.event_date
            self.event_home_team = event.event_home_team
            self.event_away_team = event.event_away_team
            self.home_team_logo =  event.event_home_team_logo
            self.away_team_logo = event.event_away_team_logo
            
        default: // tennis
            self.event_time = event.event_time
            self.event_date = event.event_date
            self.event_home_team = event.event_first_player
            self.event_away_team = event.event_second_player
            self.home_team_logo =  event.event_first_player_logo
            self.away_team_logo = event.event_second_player_logo
        }
        
    }
  
}

//MARK: - struct to latest View

struct LatestStructView {
    var  event_time : String?
    var event_date : String?
    var  event_home_team : String?
    var  event_away_team : String?
    var  home_team_logo : String?
    var  away_team_logo: String?
    var  event_final_result : String?
    
    init (sportType: String, event: Event){
        switch sportType{
            
        case K.sportsType.football.rawValue:
            self.event_time = event.event_time
            self.event_date = event.event_date
            self.event_home_team = event.event_home_team
            self.event_away_team = event.event_away_team
            self.home_team_logo =  event.home_team_logo
            self.away_team_logo = event.away_team_logo
            self.event_final_result = event.event_final_result
      
            
        case K.sportsType.cricket.rawValue:
            self.event_time = event.event_time
            self.event_date = event.event_date_stop
            self.event_home_team = event.event_home_team
            self.event_away_team = event.event_away_team
            self.home_team_logo =  event.event_home_team_logo
            self.away_team_logo = event.event_away_team_logo
            self.event_final_result = event.event_home_final_result
            
        case K.sportsType.basketball.rawValue:
            self.event_time = event.event_time
            self.event_date = event.event_date
            self.event_home_team = event.event_home_team
            self.event_away_team = event.event_away_team
            self.home_team_logo =  event.event_home_team_logo
            self.away_team_logo = event.event_away_team_logo
            self.event_final_result = event.event_final_result
            
        default: // tennis
            self.event_time = event.event_time
            self.event_date = event.event_date
            self.event_home_team = event.event_first_player
            self.event_away_team = event.event_second_player
            self.home_team_logo =  event.event_first_player_logo
            self.away_team_logo = event.event_second_player_logo
            self.event_final_result = event.event_final_result
        }
        
    }
    

}

