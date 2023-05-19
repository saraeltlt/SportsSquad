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
    var coaches : [Coach]?
    
    init(team_key: Int? = nil, team_name: String? = nil, team_logo: String? = nil, players: [Player]? = nil, coaches: [Coach]? = nil) {
        self.team_key = team_key
        self.team_name = team_name
        self.team_logo = team_logo
        self.players = players
        self.coaches = coaches
    }
}
