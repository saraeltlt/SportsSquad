//
//  FavouriteViewModel.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 23/05/2023.
//

import Foundation

class FavouriteViewModel {
    var bindFavListToFavouriteTableViewController: (() -> Void)?

    private var teamsList: [Team] = []

    var teamsCount: Int {
        return teamsList.count
    }

    func fetchTeams() {
        teamsList = DataBaseManeger.shared().getData()
        bindFavListToFavouriteTableViewController?()
    }

    func deleteTeam(at index: Int) {
        let teamId = teamsList[index].team_key ?? 0
        DataBaseManeger.shared().deleteData(teamId: teamId)
        teamsList.remove(at: index)
        bindFavListToFavouriteTableViewController?()
    }

    func team(at index: Int) -> Team {
        return teamsList[index]
    }
}
