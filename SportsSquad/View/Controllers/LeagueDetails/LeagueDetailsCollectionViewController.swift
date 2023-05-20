//
//  LeagueDetailsCollectionViewController.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 20/05/2023.
//

import UIKit


class LeagueDetailsCollectionViewController: UICollectionViewController {
    var leagueDetails : League!
    var sportType : String!
    
    var upComingList = [UpCommingEvent]()
    
    var latestEventsList = [LatestEvents]()
    
    var teamsList = [Teams]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
    
        collectionView.register(UINib(nibName: K.UPCOMING_EVENTS_CELL, bundle: nil), forCellWithReuseIdentifier: K.UPCOMING_EVENTS_CELL)
        collectionView.register(UINib(nibName: K.LATEST_EVENTS_CELL, bundle: nil), forCellWithReuseIdentifier: K.LATEST_EVENTS_CELL)
        
        APIHandler.sharedInstance.getUpComingEvents(sportType: sportType, leagueId: leagueDetails.league_key!) { upComing in
            self.upComingList = upComing.result
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        let layout = UICollectionViewCompositionalLayout{
            index, enviroment in
            switch index {
            case 0:
                return self.upComingSection()
            case 1:
                return self.latestSection()
            default:
                return self.upComingSection()
                
            }
            
            
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        
    }
    
    // MARK: - up coming events
    func upComingSection() -> NSCollectionLayoutSection{
        //section consists of group of items......
        
        //item
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        
        
        //group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(0.23)), subitems: [item])
        group.contentInsets  = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 0)
        
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .continuous
        
        
        return section
        
    }
    
    // MARK: - up coming events
    func latestSection() -> NSCollectionLayoutSection{
        //section consists of group of items......
        
        //item
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        
        
        //group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.23)), subitems: [item])
        group.contentInsets  = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 0)
        
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        
        //section.orthogonalScrollingBehavior = .continuous
        
        return section
        
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 3
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return upComingList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section{
        case 0 :
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.UPCOMING_EVENTS_CELL, for: indexPath) as! UpComingEventsCell
            
            let event = upComingList[indexPath.row]
            cell.awayTeamName.text = event.event_away_team
            cell.homeTeamName.text = event.event_home_team
            cell.awayTeamLogo.sd_setImage(with: URL(string:event.away_team_logo ?? " "), placeholderImage: UIImage(named: K.LEAGUES_PLACEHOLDER_IMAGE))
            cell.homeTeamLogo.sd_setImage(with: URL(string:event.home_team_logo ?? " "), placeholderImage: UIImage(named: K.LEAGUES_PLACEHOLDER_IMAGE))
            cell.timeAndDateText.layer.borderColor = UIColor(named: K.BLACK)?.cgColor
            cell.timeAndDateText.text = (event.event_date ?? "") + "  ⎟  " + (event.event_time ?? "")
            return cell
        case 2:
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.LATEST_EVENTS_CELL, for: indexPath) as! LatestEventCell
            
            let event = upComingList[indexPath.row]
            cell.awayTeamName.text = event.event_away_team
            cell.homeTeamName.text = event.event_home_team
            cell.awayTeamLogo.sd_setImage(with: URL(string:event.away_team_logo ?? " "), placeholderImage: UIImage(named: K.LEAGUES_PLACEHOLDER_IMAGE))
            cell.homeTeamLogo.sd_setImage(with: URL(string:event.home_team_logo ?? " "), placeholderImage: UIImage(named: K.LEAGUES_PLACEHOLDER_IMAGE))
            cell.timeAndDateText.layer.borderColor = UIColor(named: K.BLACK)?.cgColor
            cell.timeAndDateText.text = (event.event_date ?? "") + "  ⎟  " + (event.event_time ?? "")
            cell.score.text = "2 : 3"
            return cell
            
        default:
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.UPCOMING_EVENTS_CELL, for: indexPath) as! UpComingEventsCell
            
            let event = upComingList[indexPath.row]
            cell.awayTeamName.text = event.event_away_team
            cell.homeTeamName.text = event.event_home_team
            cell.awayTeamLogo.sd_setImage(with: URL(string:event.away_team_logo ?? " "), placeholderImage: UIImage(named: K.LEAGUES_PLACEHOLDER_IMAGE))
            cell.homeTeamLogo.sd_setImage(with: URL(string:event.home_team_logo ?? " "), placeholderImage: UIImage(named: K.LEAGUES_PLACEHOLDER_IMAGE))
            cell.timeAndDateText.layer.borderColor = UIColor(named: K.BLACK)?.cgColor
            cell.timeAndDateText.text = (event.event_date ?? "") + "  ⎟  " + (event.event_time ?? "")
            return cell
            
            
        }
       
        
    }
    
    
    
}
