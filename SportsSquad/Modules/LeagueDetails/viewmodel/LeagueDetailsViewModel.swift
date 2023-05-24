import Foundation

class LeagueDetailsViewModel {
    
    private let leagueId: Int
    private let sportType: String
    private let leagueName: String
    
    var bindUpcomingListToLeagueDetailsVC: (() -> Void)?
    var bindLatestEventListToLeagueDetailsVC: (() -> Void)?
    var bindTeamsListToLeagueDetailsVC: (() -> Void)?
    var bindNetworkIndicator: ((Int) -> Void)?
    var i = 0

    
    
    var upcomingList = [Event]()
    var latestEventsList = [Event]()
    var teamsList = [Team]()
    init(leagueId: Int,leagueName: String, sportType: String) {
        self.leagueId = leagueId
        self.sportType = sportType
        self.leagueName = leagueName
    }
    
    func fetchUpcomingEvents() {
        bindNetworkIndicator?(i)
        APIHandler.sharedInstance.getUpComingEvents(sportType: sportType, leagueId: leagueId) {  [weak self]  UpComingEvents in
            self?.i=self!.i+1;
            self?.bindNetworkIndicator?(self!.i)
            if let list = UpComingEvents.result{
                self?.upcomingList = list
                self?.bindUpcomingListToLeagueDetailsVC?()
            }
        }
    }
    
    func fetchLatestEvents() {
        bindNetworkIndicator?(i)
        APIHandler.sharedInstance.getLatestEvents(sportType: sportType, leagueId: leagueId) { [weak self] latest in
            self?.i=self!.i+1;
            self?.bindNetworkIndicator?(self!.i)
            if let list = latest.result{
                self?.latestEventsList = list
                self?.bindLatestEventListToLeagueDetailsVC?()
            }
        }
    }
    
    func fetchTeams() {
        bindNetworkIndicator?(i)
        if sportType == K.sportsType.tennis.rawValue{
       
            APIHandler.sharedInstance.getTennisPlayers(sportType: sportType, leagueId: leagueId) { [weak self] teams in
                self?.i=self!.i+1;
                self?.bindNetworkIndicator?(self!.i)

                if let list = teams.result{

                    for team in list{
                        let player1 = Team()
                        player1.team_name = team.event_first_player
                        player1.team_logo = team.event_first_player_logo
                        self?.teamsList.append(player1)
                        let player2 = Team()
                        player2.team_name = team.event_second_player
                        player2.team_logo = team.event_second_player
                        self?.teamsList.append(player2)
                    }
                    self?.bindTeamsListToLeagueDetailsVC?()
                }
            }
        }
        else{
            APIHandler.sharedInstance.getTeams(sportType: sportType, leagueId: leagueId) { [weak self] teams in
                self?.i=self!.i+1;
                self?.bindNetworkIndicator?(self!.i)
                if let list = teams.result{
                    self?.teamsList = list
                    self?.bindTeamsListToLeagueDetailsVC?()
                }
            }
        }
       
    }
    
   
    
    func getUpComingEvents(at index: Int) -> UpComingStructView {
       return UpComingStructView(sportType: sportType, event: upcomingList[index])
    }
    
    func getLatestEvents(at index: Int) -> LatestStructView {
        return LatestStructView(sportType: sportType, event: latestEventsList[index])
    
    }
    func getTeams(at index: Int) -> TeamsStructView {
        return TeamsStructView(sportType: sportType, team: teamsList[index])
    }
    
    
    func setTeamsLabel() -> String {
        if sportType == K.sportsType.tennis.rawValue  {
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
    func getSportType() -> String {
        return sportType
    }
    func getleagueName() -> String {
        return leagueName
    }
    
    
}
