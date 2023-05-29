//
//  LeaguesDetailsCollectionView.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 28/05/2023.
//

import UIKit

extension LeagueDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == upcomingCollectionView {
            return detailsViewModel.upcomingList.count
        } else if collectionView == latestCollectionView {
            return detailsViewModel.latestEventsList.count
        } else {
            return detailsViewModel.teamsList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == upcomingCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.UPCOMING_EVENTS_CELL, for: indexPath) as! UpComingEventsCell
            let event = detailsViewModel.getUpComingEvents(at: indexPath.row)
                  cell.configure(with: event)
            
            return cell
        } else if collectionView == latestCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.LATEST_EVENTS_CELL, for: indexPath) as! LatestEventCell
            let event = detailsViewModel.getLatestEvents(at:indexPath.row)
                  cell.configure(with: event)
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.TEAMS_CELL, for: indexPath) as! TeamsCell
    
            let team = detailsViewModel.getTeams(at: indexPath.row)
            cell.configure(with: team, sportType: detailsViewModel.getSportType())
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == teamsCollectionView {
            if detailsViewModel.getSportType() == K.sportsType.football.rawValue {
                let teamDetailsVC = self.storyboard!.instantiateViewController(withIdentifier: "TeamsDetailsViewController") as! TeamsDetailsViewController
                
                teamDetailsVC.viewModel = detailsViewModel.navigationConfig(for: indexPath.row)
                self.navigationController?.pushViewController(teamDetailsVC, animated: true)
             
            } else {
               showNoDetailsAlert()

            }
        }
    }
}

