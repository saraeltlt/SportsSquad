//
//  TeamsModel.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 19/05/2023.
//

import Foundation
class TeamsModel :Decodable{
    var success : Int?
    var result : [Teams]
}

class Teams : Decodable {
    var team_key : Int?
    var team_name : String?
    var team_logo : String?
    var players : [Player]?
    var coaches = [Coach]()
    
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

