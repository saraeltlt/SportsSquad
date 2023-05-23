//
//  DatabaseServiceProtocol.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 20/05/2023.
//

import Foundation
protocol DatabaseServiceProtocol {
    func saveData(teamData : Teams)
    func getData() -> [Teams] 
    func deleteData(teamId:Int)
    func isFav(teamId: Int) -> Bool 
}
