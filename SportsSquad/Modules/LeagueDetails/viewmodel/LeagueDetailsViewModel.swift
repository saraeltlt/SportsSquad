import Foundation

class LeagueDetailsViewModel {
    
    private let leagueId: Int
    private let sportType: String
    private let leagueName: String
    
    var bindUpcomingListToLeagueDetailsVC: (() -> Void)?
    var bindLatestEventListToLeagueDetailsVC: (() -> Void)?
    var bindTeamsListToLeagueDetailsVC: (() -> Void)?
    
    var upcomingList = [UpCommingEvent]()
    var latestEventsList = [LatestEvents]()
    var teamsList = [Teams]()
  
    init(leagueId: Int,leagueName: String, sportType: String) {
        self.leagueId = leagueId
        self.sportType = sportType
        self.leagueName = leagueName
    }
    
    func fetchUpcomingEvents() {
        APIHandler.sharedInstance.getUpComingEvents(sportType: sportType, leagueId: leagueId) {  [weak self]  UpComingEvents in
            self?.upcomingList = UpComingEvents.result
            self?.bindUpcomingListToLeagueDetailsVC?()
        }
    }
    
    func fetchLatestEvents() {
        APIHandler.sharedInstance.getLatestEvents(sportType: sportType, leagueId: leagueId) { [weak self] latest in
            self?.latestEventsList = latest.result
            self?.bindLatestEventListToLeagueDetailsVC?()
        }
    }
    
    func fetchTeams() {
        APIHandler.sharedInstance.getTeams(sportType: sportType, leagueId: leagueId) { [weak self] teams in
            self?.teamsList = teams.result
            self?.bindTeamsListToLeagueDetailsVC?()
        }
    }
    
    func getSportType() -> String {
        return sportType
    }
    func getleagueName() -> String {
        return leagueName
    }
    
    func setTeamsLabel() -> String {
        if sportType == "tennis" || sportType == "cricket" {
            return "  Players"
        } else {
            return "  Teams"
        }
    }
    
    func getUpcomingListCount() -> Int {
        return upcomingList.count
    }
    
    func getLatestEventsListCount() -> Int {
        return latestEventsList.count
    }
    
    func getTeamsListCount() -> Int {
        return teamsList.count
    }
    
}
