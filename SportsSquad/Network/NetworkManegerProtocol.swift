//
//  APIHandlerProtocol.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 19/05/2023.
//

import Foundation
protocol NetworkManegerProtocol  {
    
    
    func getLeagues(sportType: String , completionHandler : @escaping(_ leagues:LeaguesModel)  -> (Void) )
    
    func getUpComingEvents(sportType: String ,leagueId: Int, completionHandler : @escaping(_ UpComingEvents:EventsModel) -> Void)
    
    func getLatestEvents(sportType: String, leagueId: Int, completionHandler: @escaping (EventsModel) -> Void)
    
    func getTeams(sportType: String ,leagueId: Int , completionHandler: @escaping (TeamsModel) -> Void )
    
    func getTennisPlayers(sportType: String, leagueId: Int, completionHandler: @escaping (TeamsModel) -> Void)
   
    func getTeamDetails(teamId: Int , completionHandler: @escaping (TeamsModel) -> Void )
    
}
