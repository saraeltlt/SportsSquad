import Foundation

class LeagueDetailsViewModel {
    
    private let leagueId: Int
    private let sportType: String
    private let leagueName: String
    var todayString: String
    var yesterdayString: String
    
    var bindUpcomingListToLeagueDetailsVC:Observable<Bool>=Observable(false)
    var bindLatestEventListToLeagueDetailsVC:Observable<Bool>=Observable(false)
    var bindTeamsListToLeagueDetailsVC:Observable<Bool>=Observable(false)
    var bindNetworkIndicator:Observable<Int>=Observable(0)
    var i = 0
    var upcomingList = [Event]()
    var latestEventsList = [Event]()
    var teamsList = [Team]()
    
    
    
    init(leagueId: Int,leagueName: String, sportType: String) {
        self.leagueId = leagueId
        self.sportType = sportType
        self.leagueName = leagueName

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
       yesterdayString = dateFormatter.string(from: yesterday!)
        todayString = dateFormatter.string(from: Date())
    }
    
    func fetchUpcomingEvents() {
        bindNetworkIndicator.value=i
        let url = "\(K.BASIC_URL)\(sportType)/?met=Fixtures&leagueId=\(leagueId)&from=\(todayString)&to=2025-01-01&APIkey=\(K.API_KEY)"
        NetworkManeger.shared.getApiData(url: url) { [weak self] (result: Result<EventsModel, Error>) in
            switch result {
            case .success(let upcomingEvents):
                self?.i += 1
                self?.bindNetworkIndicator.value=self?.i
                if let list = upcomingEvents.result {
                    self?.upcomingList = list
                    self?.bindUpcomingListToLeagueDetailsVC.value=true
                }
            case .failure(let error):
                // Handle error
                print(error)
            }
        }
    }
    
    func fetchLatestEvents() {
        bindNetworkIndicator.value=i
        let url = "\(K.BASIC_URL)\(sportType)/?met=Fixtures&APIkey=\(K.API_KEY)&from=2022-8-01&to=\(yesterdayString)&leagueId=\(leagueId)"
        
        NetworkManeger.shared.getApiData(url: url) { [weak self] (result: Result<EventsModel, Error>) in
            switch result {
            case .success(let latest):
                self?.i += 1
                self?.bindNetworkIndicator.value=self?.i
                if let list = latest.result {
                    self?.latestEventsList = list.reversed()
                    self?.bindLatestEventListToLeagueDetailsVC.value=true
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func fetchTeams() {
        bindNetworkIndicator.value=i
        if sportType == K.sportsType.tennis.rawValue {
            let url = "\(K.BASIC_URL)\(sportType)/?met=Fixtures&leagueId=\(leagueId)&from=2021-01-23&to=2023-12-30&APIkey=\(K.API_KEY)"
            
            NetworkManeger.shared.getApiData(url: url) { [weak self] (result: Result<TeamsModel, Error>) in
                switch result {
                case .success(let teams):
                    self?.i += 1
                    self?.bindNetworkIndicator.value=self?.i

                    if let list = teams.result {
                        for team in list {
                            let player1 = Team()
                            player1.team_name = team.event_first_player
                            player1.team_logo = team.event_first_player_logo
                            self?.teamsList.append(player1)
                            let player2 = Team()
                            player2.team_name = team.event_second_player
                            player2.team_logo = team.event_second_player
                            self?.teamsList.append(player2)
                        }
                        self?.bindTeamsListToLeagueDetailsVC.value=true
                    }
                case .failure(let error):
                    // Handle error
                    print(error)
                }
            }
        } else {
            let url = "\(K.BASIC_URL)\(sportType)/?met=Teams&?met=Leagues&leagueId=\(leagueId)&APIkey=\(K.API_KEY)"

            NetworkManeger.shared.getApiData(url: url) { [weak self] (result: Result<TeamsModel, Error>) in
                switch result {
                case .success(let teams):
                    self?.i += 1
                    self?.bindNetworkIndicator.value=self?.i
                    if let list = teams.result {
                        self?.teamsList = list
                        self?.bindTeamsListToLeagueDetailsVC.value=true
                    }
                case .failure(let error):
                    // Handle error
                    print(error)
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
    
    
    func  navigationConfig(for rowIndex:Int) -> TeamDetailsViewModel {
        let teamId = teamsList[rowIndex].team_key!
        let teamName = teamsList[rowIndex].team_name!
        
        return TeamDetailsViewModel(teamId: teamId, teamName: teamName)
        
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
