//
//  FetchTeamsProtocol.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 20/05/2023.
//

import Foundation
protocol FetchTeamsProtocol {
    static func getTeams(sportName: String ,leagueId: Int , completionHandler: @escaping (TeamsModel?) -> Void )
    
    static func getTeamDetails(teamId: Int , completionHandler: @escaping (TeamsModel?) -> Void )
}
