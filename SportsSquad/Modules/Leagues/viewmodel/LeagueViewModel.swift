//
//  LeagueViewModel.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 23/05/2023.
//

import Foundation
class LeaguesViewModel {
    private var sportType: String! 
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
        NetworkManeger.getInstance().getLeagues(sportType: sportType) { [weak self] leagues in
            self?.leagueList = leagues.result!
            self?.bindListToLeagueTableViewController?()
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
