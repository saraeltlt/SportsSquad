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
    static let API_KEY = "c0bddea4fa8a6125d9d6a00001e9ecd71e7107a99aeef4d1154c551d2feb96e8"
    
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
    static let NO_WIFI = "noWifi"
    static let FAV_IMAGE = "addFav"
    static let WIFI_Alert_IMAGE = "wifiAlert"
    static let DELETE_ALERT_IMAGE = "deleteAlert"
    static let NO_INO_IMAGE = "noInfoAlert"
    
    //colors
    static let MEDIUM_PURPLE = "MidumPurple"
    static let BLUE = "Blue"
    static let LIGHT_PURPLE = "LightPurple"
    static let DARK_PURPLE = "DarkPurple"
    static let BLACK = "Black"
    static let WHITE = "White"
    static let FAV_COLOR = "favColor"
    static let TAB_BAR_TINT = "tabBarTint"
    
    
}

