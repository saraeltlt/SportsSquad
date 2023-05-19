//
//  APIHandlerProtocol.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 19/05/2023.
//

import Foundation
protocol APIHandlerProtocol{
    func getLeagues(team: String , handler : @escaping(_ leagues:LeaguesModel)  -> (Void) )
}
