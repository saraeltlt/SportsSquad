//
//  LeaguesModel.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 19/05/2023.
//

import Foundation
import Foundation
import UIKit


class LeaguesModel : Decodable {
    var result : [League]
    var success : Int?
}
class League : Decodable {
    var league_key:Int?
    var league_name:String?
    var league_logo:String?
    var country_key:Int?
    var country_name:String?
}
 //MARK: - struct to leagues View

struct LeagueStructView {
    var league_name:String
    var league_logo:String
    var league_key:Int
    init (_ league:League){
        league_name = league.league_name ?? "League"
        league_logo = league.league_logo ?? " "
        league_key = league.league_key ?? 0
    }
}
