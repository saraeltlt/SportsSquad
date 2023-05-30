//
//  LeagueViewModel.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 23/05/2023.
//

import Foundation
class LeaguesViewModel {
    private var sportType: String
    private var leagueList: [League] = []
    private var searchArray: [League] = []
    init( sportType: String){
        self.sportType = sportType
    }
    var isSearching: Bool = false
    
    var bindListToLeagueTableViewController: (() -> Void)?
    
    var bindNetworkIndicator: ((Bool) -> Void)?
    
    
    func getLeaguesAPI() {
        bindNetworkIndicator?(true)
        let url = "\(K.BASIC_URL)\(sportType)/?met=Leagues&APIkey=\(K.API_KEY)"
        
        NetworkManeger.shared.getApiData(url: url) { [weak self] (result: Result<LeaguesModel, Error>) in
            switch result {
            case .success(let leagues):
                self?.leagueList = leagues.result!
                self?.bindListToLeagueTableViewController?()
                print(leagues)
            case .failure(let error):
                print(error)
            }
            self?.bindNetworkIndicator?(false)
        }
    }
    
    
    
    func filterLeagues(with searchText: String) {
        if searchText.isEmpty {
             isSearching = false
             searchArray.removeAll()
         } else {
             isSearching = true
             searchArray = leagueList.filter { $0.league_name?.lowercased().contains(searchText.lowercased()) ?? false }
         }
         bindListToLeagueTableViewController?()
    }
    
    func getLeague(at index: Int) -> LeagueStructView {
        if isSearching {
           return LeagueStructView (searchArray[index])
        } else {
            return LeagueStructView (leagueList[index])
        }
    }
    
    
    var numberOfLeagues: Int {
        if isSearching {
            return searchArray.count
        } else {
            return leagueList.count
        }
    }
    func getSportType() -> String {
        return sportType
    }
    
    
    func  navigationConfig(for rowIndex:Int) -> LeagueDetailsViewModel {
       let leagueId = self.getLeague(at: rowIndex).league_key
       let leagueName = self.getLeague(at: rowIndex).league_name
       
       return LeagueDetailsViewModel(leagueId: leagueId, leagueName: leagueName, sportType: sportType)
    }

   
    
   
}
