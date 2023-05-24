//
//  Constants.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 18/05/2023.
//

import Foundation
struct K {
    enum sportsType:String {
        case football = "football"
        case basketball = "basketball"
        case tennis = "tennis"
        case cricket = "cricket"
    }

    //URL
    static let BASIC_URL = "https://apiv2.allsportsapi.com/"
    //keys
    static let APPERANCE_MODE_KEY = "AppearanceMode"
    static let API_KEY = "097bcb5d95f937c824bc73356efa4f56d12446d32e8245d2ad36950c16294ab7"
    
    //coredata
    static let ENTITY_NAME="FavTeams"

    //cells
    static let LEAGUES_CELL = "LeaguesCell"
    static let FAVOURITE_CELL = "FavCell"
    static let UPCOMING_EVENTS_CELL = "UpComingEventsCell"
    static let LATEST_EVENTS_CELL = "LatestEventCell"
    static let TEAMS_CELL = "TeamsCell"
    static let TEAM_DETAILS_CELL = "TeamDetailsCell"
    
    //images
    static let LEAGUES_PLACEHOLDER_IMAGE = "LeaguesPlaceHolder"
    static let BACK_ARROW = "BackArrow"
    static let TEAMS_PLACEHOLDER_IMAGE = "TeamPlaceHolder"
    static let Player_PLACEHOLDER_IMAGE="playerPlaceHolder"
    
    //colors
    static let MEDIUM_PURPLE = "MidumPurple"
    static let BLUE = "Blue"
    static let LIGHT_PURPLE = "LightPurple"
    static let DARK_PURPLE = "DarkPurple"
    static let BLACK = "Black"
    static let WHITE = "White"
    static let favColor = "favColor"
    
}

