//
//  TeamDetailsViewModel.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 23/05/2023.
//

class TeamDetailsViewModel {
    var teamId: Int
    var teamName: String
    var isFav: Bool {
     DataBaseManeger.shared().isFav(teamId: teamId)
    }
    var team = Team()
    var bindTeamsListToTeamDetailsVC: (() -> Void)?
    var bindNetworkIndicator: ((Bool) -> Void)?
    
    init(teamId: Int, teamName: String) {
        self.teamId = teamId
        self.teamName = teamName

    }
    
    func fetchTeamDetails() {
        bindNetworkIndicator?(true)
        APIHandler.sharedInstance.getTeamDetails(teamId: teamId) { [weak self] players in
            if let list = players.result{
                self?.team = list[0]
                self?.bindTeamsListToTeamDetailsVC?()
                self?.bindNetworkIndicator?(false)
                
            }
        }
    }
    
    func toggleFavorite() {
        if isFav {
            DataBaseManeger.shared().deleteData(teamId: teamId)
        } else {
            DataBaseManeger.shared().saveData(teamData: team)
        }
    }
}
