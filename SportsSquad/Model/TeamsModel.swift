//
//  TeamsModel.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 19/05/2023.
//

import Foundation
class TeamsModel :Decodable{
    var success : Int?
    var result : [Team]?

}

class Team : Decodable {
    var team_key : Int?
    var team_name : String?
    var team_logo : String?
    
    //football
    var players : [Player]?
    var coaches : [Coach]?
    
    //for tennis
    var event_first_player: String?
    var event_second_player: String?
    var event_first_player_logo: String?
    var event_second_player_logo: String?
    
    
    
}

class Player :Decodable {
    var player_name : String?
    var player_type : String?
    var player_number : String?
    var player_image : String?
    var player_age : String?
}

class Coach : Decodable{
    var coach_name : String?
}

//MARK: - struct to teams View
struct TeamsStructView {
    var team_key : Int?
    var team_name : String?
    var team_logo : String?
    var players : [Player]?
    var coaches : [Coach]?

    
    init(sportType:String, team:Team){
        if sportType == K.sportsType.football.rawValue{
            self.coaches = team.coaches
            self.players = team.players
            self.team_key = team.team_key
        }
        self.team_logo = team.team_logo
        self.team_name = team.team_name

    
    }
}
