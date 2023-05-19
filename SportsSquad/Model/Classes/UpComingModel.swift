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
    var event_home_team : String?
    var event_away_team : String?
    var home_team_logo : String?
    var away_team_logo : String?
    
    enum CodingKeys : String, CodingKey{
        case  event_date, event_time
        case event_home_team, event_away_team
        case home_team_logo
        case away_team_logo
        case event_home_team_logo, event_away_team_logo

        
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.event_date = try container.decodeIfPresent(String.self, forKey: .event_date)
        self.event_time = try container.decodeIfPresent(String.self, forKey: .event_time)
        self.event_home_team = try container.decodeIfPresent(String.self, forKey: .event_home_team)
        self.event_away_team = try container.decodeIfPresent(String.self, forKey: .event_away_team)
        self.home_team_logo = try container.decodeIfPresent(String.self, forKey: .home_team_logo) ?? container.decodeIfPresent(String.self, forKey: .event_home_team_logo)
        self.away_team_logo = try container.decodeIfPresent(String.self, forKey: .away_team_logo) ?? container.decodeIfPresent(String.self, forKey: .event_away_team_logo)
    }
}
