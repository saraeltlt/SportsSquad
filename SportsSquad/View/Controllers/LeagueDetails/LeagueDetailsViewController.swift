//
//  LeagueDetailsViewController.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 20/05/2023.
//

import UIKit

class LeagueDetailsViewController: UIViewController {
    var leagueDetails : League!
    var sportType : String!
    
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    var upComingList = [UpCommingEvent]()
    
    @IBOutlet weak var LatestCollectionView: UICollectionView!
    var latestEventsList = [LatestEvents]()
    
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    var teamsList = [Teams]()

    override func viewDidLoad() {
        super.viewDidLoad()
        upcomingCollectionView.delegate = self
        upcomingCollectionView.dataSource = self
        LatestCollectionView.delegate = self
        LatestCollectionView.dataSource = self
        teamsCollectionView.delegate = self
        teamsCollectionView.dataSource = self
        
        
        upcomingCollectionView.register(UINib(nibName: K.UPCOMING_EVENTS_CELL, bundle: nil), forCellWithReuseIdentifier: K.UPCOMING_EVENTS_CELL)
        
        LatestCollectionView.register(UINib(nibName: K.LATEST_EVENTS_CELL, bundle: nil), forCellWithReuseIdentifier: K.LATEST_EVENTS_CELL)
        
        teamsCollectionView.register(UINib(nibName: K.UPCOMING_EVENTS_CELL, bundle: nil), forCellWithReuseIdentifier: K.UPCOMING_EVENTS_CELL)
        
        APIHandler.sharedInstance.getUpComingEvents(sportType: sportType, leagueId: leagueDetails.league_key!) { upComing in
            self.upComingList = upComing.result
            DispatchQueue.main.async {
                self.upcomingCollectionView.reloadData()
                self.LatestCollectionView.reloadData()
                self.teamsCollectionView.reloadData()
            }
        }
        let layout = UICollectionViewCompositionalLayout{
            index, enviroment in
            return self.upComingSection()
            
        }
        
        let layoutLatest = UICollectionViewCompositionalLayout{
            index, enviroment in
            return self.latestSection()
            
        }
        upcomingCollectionView.setCollectionViewLayout(layout, animated: true)
        LatestCollectionView.setCollectionViewLayout(layoutLatest, animated: true)
        teamsCollectionView.setCollectionViewLayout(layout, animated: true)
        
        


    }
    
    
    // MARK: - up coming events
    func upComingSection() -> NSCollectionLayoutSection{
        //section consists of group of items......
        
        //item
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        
        
        //group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(190)), subitems: [item])
        group.contentInsets  = NSDirectionalEdgeInsets(top: 16, leading: 10, bottom: 11, trailing: 0)
        
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .continuous
        
        
        return section
        
    }
    
    // MARK: - Latest events
    func latestSection() -> NSCollectionLayoutSection{
        //section consists of group of items......
        
        //item
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        
        
        //group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.8)), subitems: [item])
        group.contentInsets  = NSDirectionalEdgeInsets(top: 5, leading: 32, bottom: 5, trailing: 32)
        
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        
        //section.orthogonalScrollingBehavior = .continuous
        
        return section
        
    }
    



}


// MARK: - UICollectionView

extension LeagueDetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == upcomingCollectionView){
            return upComingList.count
        }
        else if (collectionView == LatestCollectionView){
            return upComingList.count
        }
        else{
            return upComingList.count
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == upcomingCollectionView){
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
        else if (collectionView == LatestCollectionView){
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

        }
        else{
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

