//
//  APIHandlerProtocol.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 19/05/2023.
//

import Foundation
protocol NetworkManegerProtocol  {
    
    
    func getLeagues(sportType: String, completionHandler: @escaping (Result<LeaguesModel, Error>) -> Void)
    
    func getUpComingEvents(sportType: String, leagueId: Int, completionHandler: @escaping (Result<EventsModel, Error>) -> Void)
    
    func getLatestEvents(sportType: String, leagueId: Int, completionHandler: @escaping (Result<EventsModel, Error>) -> Void)
    func getTeams(sportType: String, leagueId: Int, completionHandler: @escaping (Result<TeamsModel, Error>) -> Void)
    
    func getTennisPlayers(sportType: String, leagueId: Int, completionHandler: @escaping (Result<TeamsModel, Error>) -> Void)
   
    func getTeamDetails(teamId: Int, completionHandler: @escaping (Result<TeamsModel, Error>) -> Void)
    
}
