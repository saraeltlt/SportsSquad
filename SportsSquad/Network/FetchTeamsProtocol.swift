//
//  FetchTeamsProtocol.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 20/05/2023.
//

import Foundation
protocol FetchTeamsProtocol {
     func getTeams(sportType: String ,leagueId: Int , completionHandler: @escaping (TeamsModel) -> Void )
     func getTennisPlayers(sportType: String, leagueId: Int, completionHandler: @escaping (TeamsModel) -> Void)
    
     func getTeamDetails(teamId: Int , completionHandler: @escaping (TeamsModel) -> Void )
}
