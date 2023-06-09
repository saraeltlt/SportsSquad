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
     DataBaseManeger.shared.isFav(teamId: teamId)
    }
    var team = Team()
    var bindTeamsListToTeamDetailsVC:Observable<Bool>=Observable(false)
    
    init(teamId: Int, teamName: String) {
        self.teamId = teamId
        self.teamName = teamName

    }
    
    func fetchTeamDetails() {
        let url = "\(K.BASIC_URL)football/?&met=Teams&teamId=\(teamId)&APIkey=\(K.API_KEY)"
        NetworkManeger.shared.getApiData(url: url) { [weak self] (result: Result<TeamsModel, Error>) in
            switch result {
            case .success(let team):
                self?.team = team.result![0]
                self?.bindTeamsListToTeamDetailsVC.value=true
            case .failure(let error):
                self?.bindTeamsListToTeamDetailsVC.value=false
                print("Failed to fetch team details: \(error)")
            }
        }
    }
    
    func toggleFavorite() {
        if isFav {
            DataBaseManeger.shared.deleteData(teamId: teamId)
        } else {
            DataBaseManeger.shared.saveData(teamData: team)
        }
    }
}
