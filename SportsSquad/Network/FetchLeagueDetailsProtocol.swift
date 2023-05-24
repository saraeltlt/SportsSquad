//
//  FetchLeagueDetailsProtocol.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 20/05/2023.
//

import Foundation
protocol FetchLeagueDetailsProtocol{
    
    func getUpComingEvents(sportType: String ,leagueId: Int, completionHandler : @escaping(_ UpComingEvents:EventsModel) -> Void)
    
    func getLatestEvents(sportType: String, leagueId: Int, completionHandler: @escaping (EventsModel) -> Void)
    
}
