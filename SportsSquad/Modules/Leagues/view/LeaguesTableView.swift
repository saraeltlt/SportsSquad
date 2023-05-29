//
//  LeaguesTableView.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 28/05/2023.
//

import UIKit


extension LeaguesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaguesViewModel.numberOfLeagues
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.LEAGUES_CELL, for: indexPath) as! LeaguesCell
        cell.configure(league: leaguesViewModel.getLeague(at: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let detailsVC = self.storyboard!.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as! LeagueDetailsViewController
        
        detailsVC.detailsViewModel = leaguesViewModel.navigationConfig(for: indexPath.row)

        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
        cell.layer.transform = rotationTransform
        cell.alpha=0.5
        UIView.animate(withDuration: 1.0) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha=1.0
        }
    }
    
    
}
