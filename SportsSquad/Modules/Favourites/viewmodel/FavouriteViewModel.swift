//
//  FavouriteViewModel.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 23/05/2023.
//

import Foundation

class FavouriteViewModel {
    var bindFavListToFavouriteTableViewController:Observable<Bool>=Observable(false)

    private var teamsList: [Team] = []

    var teamsCount: Int {
        return teamsList.count
    }

    func fetchTeams() {
        teamsList = DataBaseManeger.shared.getData()
        bindFavListToFavouriteTableViewController.value=true
    }

    func deleteTeam(at index: Int) {
        let teamId = teamsList[index].team_key ?? 0
        DataBaseManeger.shared.deleteData(teamId: teamId)
        teamsList.remove(at: index)
        bindFavListToFavouriteTableViewController.value=true
    }

    func team(at index: Int) -> Team {
        return teamsList[index]
    }
    func isInternetAvailable() -> Bool {
        if NetworkStatusChecker.isInternetAvailable(){
            return true
        }
        else{
            return false
            
        }
    }
    
    func  navigationConfig(for rowIndex:Int) -> TeamDetailsViewModel {
        let teamId = teamsList[rowIndex].team_key!
        let teamName = teamsList[rowIndex].team_name!
        
        return TeamDetailsViewModel(teamId: teamId, teamName: teamName)
        
    }
}
