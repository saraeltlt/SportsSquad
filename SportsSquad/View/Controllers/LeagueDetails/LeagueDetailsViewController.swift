//
//  LeagueDetailsViewController.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 19/05/2023.
//

import UIKit

class LeagueDetailsViewController: UIViewController {

    var leagueDetails : League!
    var sportType : String!
    
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    var upComingList = [UpCommingEvent]()
    
    var latestEventsList = [LatestEvents]()
    
    var teamsList = [Teams]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //upComing collection
        upcomingCollectionView.delegate = self
        upcomingCollectionView.dataSource = self
        APIHandler.sharedInstance.getUpComingEvents(sportType: sportType, leagueId: leagueDetails.league_key!) { upComing in
            self.upComingList = upComing.result
            DispatchQueue.main.async {
                self.upcomingCollectionView.reloadData()
            }
        }
        let upComingLayout = UICollectionViewCompositionalLayout{
            index, enviroment in
                return self.upComingSection()
            }
        upcomingCollectionView.setCollectionViewLayout(upComingLayout, animated: true)


        //..

        
    }
    // MARK: - up coming events
    func upComingSection() -> NSCollectionLayoutSection{
        //section consists of group of items......

        //item
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))



        //group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(100)), subitems: [item])
        group.contentInsets  = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)


        //section
        let section = NSCollectionLayoutSection(group: group)

        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top:8, leading: 8, bottom: 0, trailing: 8)

        return section

    }
    



}

// MARK: - UICollectionView

extension LeagueDetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == upcomingCollectionView){
            return upComingList.count
        }
        else{
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == upcomingCollectionView){
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.UPCOMING_EVENTS_CELL, for: indexPath) as! UpcomingEventsCell
            let event = upComingList[indexPath.row]
            cell.awayTeamName.text = event.event_away_team
            cell.homeTeamName.text = event.event_home_team
            cell.awayTeamLogo.sd_setImage(with: URL(string:event.away_team_logo ?? " "), placeholderImage: UIImage(named: K.LEAGUES_PLACEHOLDER_IMAGE))
            cell.homeTeamLogo.sd_setImage(with: URL(string:event.home_team_logo ?? " "), placeholderImage: UIImage(named: K.LEAGUES_PLACEHOLDER_IMAGE))
            cell.timeAndDateText.text = (event.event_date ?? "") + "/" + (event.event_time ?? "")
            return cell
        }
        else{
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.UPCOMING_EVENTS_CELL, for: indexPath) as! UpcomingEventsCell
            return cell
        }
  
    }
    
  
}
