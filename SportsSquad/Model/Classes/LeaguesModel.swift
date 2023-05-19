//
//  LeaguesModel.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 19/05/2023.
//

import Foundation
import Foundation
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
