//
//  LeaguesSearch.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 28/05/2023.
//

import UIKit

extension LeaguesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        leaguesViewModel?.filterLeagues(with: searchText)
        if searchBar.text!.isEmpty{
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
   func updateNoSearchResultVisibility() {
        if leaguesViewModel.numberOfLeagues == 0 {
            noSearchResult.isHidden = false
        } else {
            noSearchResult.isHidden = true
        }
    }
}
