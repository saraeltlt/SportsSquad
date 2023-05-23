//
//  TeamDetailsViewModel.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 23/05/2023.
//


class TeamDetailsViewModel {
    var teamId: Int
    var teamName: String
    var isFav: Bool
    var team: Teams = Teams()
    var bindTeamsListToTeamDetailsVC: (() -> Void)?

    init(teamId: Int, teamName: String, isFav: Bool = false) {
        self.teamId = teamId
        self.teamName = teamName
        self.isFav = isFav
    }

    func getTeamDetails(completion: @escaping (Teams) -> Void) {
        APIHandler.sharedInstance.getTeamDetails(teamId: teamId) { players in
            self.team = players.result[0]
            completion(self.team)
        }
    }

    func updateFavoriteStatus() {
        if isFav {
            DataBaseManeger.shared().deleteData(teamId: teamId)
        } else {
            DataBaseManeger.shared().saveData(teamData: team)
        }
        isFav = !isFav
        bindTeamsListToTeamDetailsVC?()
    }
}
