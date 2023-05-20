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
  
    @IBOutlet weak var noUpComing: UIButton!
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    var upComingList = [UpCommingEvent]()
    
    @IBOutlet weak var noLatest: UIButton!
    @IBOutlet weak var LatestCollectionView: UICollectionView!
    var latestEventsList = [LatestEvents]()
    
    @IBOutlet weak var noTeams: UIButton!
    @IBOutlet weak var TeamsOrPlayerLabel: UILabel!
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    var teamsList = [Teams]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        upcomingCollectionView.delegate = self
        upcomingCollectionView.dataSource = self
        
        LatestCollectionView.delegate = self
        LatestCollectionView.dataSource = self
        
        teamsCollectionView.delegate = self
        teamsCollectionView.dataSource = self
        
        if sportType == "tennis" || sportType == "cricket"{
            TeamsOrPlayerLabel.text="  Players"
        }
        
        upcomingCollectionView.register(UINib(nibName: K.UPCOMING_EVENTS_CELL, bundle: nil), forCellWithReuseIdentifier: K.UPCOMING_EVENTS_CELL)
        
        LatestCollectionView.register(UINib(nibName: K.LATEST_EVENTS_CELL, bundle: nil), forCellWithReuseIdentifier: K.LATEST_EVENTS_CELL)
        
        teamsCollectionView.register(UINib(nibName: K.TEAMS_CELL, bundle: nil), forCellWithReuseIdentifier: K.TEAMS_CELL)
        
        APIHandler.sharedInstance.getUpComingEvents(sportType: sportType, leagueId: leagueDetails.league_key!) { upComing in
            self.upComingList = upComing.result
            DispatchQueue.main.async {
                self.upcomingCollectionView.reloadData()
            }
        }
        
        APIHandler.sharedInstance.getLatestEvents(sportType: sportType, leagueId: leagueDetails.league_key!) { latest in
            self.latestEventsList = latest.result
            DispatchQueue.main.async {
                self.LatestCollectionView.reloadData()
            }
            
        }
        
        APIHandler.sharedInstance.getTeams(sportType: sportType, leagueId: leagueDetails.league_key!) { teams in
            self.teamsList = teams.result
            DispatchQueue.main.async {
                self.teamsCollectionView.reloadData()
            }
            
        }
        
        let layout = UICollectionViewCompositionalLayout{
            index, enviroment in
            return self.upComingSection()
        }
        upcomingCollectionView.setCollectionViewLayout(layout, animated: true)
        
        let layoutLatest = UICollectionViewCompositionalLayout{
            index, enviroment in
            return self.latestSection()
        }
        let layoutTeams = UICollectionViewCompositionalLayout{
            index, enviroment in
            return self.teamsSection()
        }
        LatestCollectionView.setCollectionViewLayout(layoutLatest, animated: true)
        teamsCollectionView.setCollectionViewLayout(layoutTeams, animated: true)
        
        


    }
    
    
    // MARK: - up coming events
    func upComingSection() -> NSCollectionLayoutSection{
        //item
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))

        //group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(195)), subitems: [item])
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
    
    // MARK: - teams
    func teamsSection() -> NSCollectionLayoutSection{
        //item
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3333), heightDimension: .fractionalHeight(1)))

        //group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(1)), subitems: [item])
        group.contentInsets  = NSDirectionalEdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 0)
        
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .continuous
        
        
        return section
        
    }
    
    
    
    
    
    // MARK: - Back
     
        private func configNavigationBar(){
            //edit back button
            let backButton = UIButton(type: .custom)
            backButton.setImage(UIImage(named: K.BACK_ARROW), for: .normal)
            backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
            navigationItem.leftBarButtonItem =  UIBarButtonItem(customView: backButton)
            
            //edit title
            let textAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor(named: K.DARK_PURPLE)!,
                .font: UIFont(name: "Chalkduster", size: 17.0)!,
            ]
            navigationController?.navigationBar.titleTextAttributes = textAttributes
            self.title = "\(leagueDetails.league_name!)"
        }
        @IBAction func logoPressed(_ sender: UIButton) {
            self.navigationController?.popToRootViewController(animated: true)
        }
        @objc func backButtonTapped() {
            self.navigationController?.popViewController(animated: true)
        }
        


}


// MARK: - UICollectionView

extension LeagueDetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == upcomingCollectionView){
           noUpComing.isHidden = !upComingList.isEmpty
            return upComingList.count
        }
        else if (collectionView == LatestCollectionView){
           noLatest.isHidden = !latestEventsList.isEmpty
            return latestEventsList.count
        }
        else{
           noTeams.isHidden = !teamsList.isEmpty
            return teamsList.count
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == upcomingCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.UPCOMING_EVENTS_CELL, for: indexPath) as! UpComingEventsCell
            
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.LATEST_EVENTS_CELL, for: indexPath) as! LatestEventCell
            
            let event = latestEventsList[indexPath.row]
            cell.awayTeamName.text = event.event_away_team
            cell.homeTeamName.text = event.event_home_team
            cell.awayTeamLogo.sd_setImage(with: URL(string:event.away_team_logo ?? " "), placeholderImage: UIImage(named: K.LEAGUES_PLACEHOLDER_IMAGE))
            cell.homeTeamLogo.sd_setImage(with: URL(string:event.home_team_logo ?? " "), placeholderImage: UIImage(named: K.LEAGUES_PLACEHOLDER_IMAGE))
            cell.timeAndDateText.layer.borderColor = UIColor(named: K.BLACK)?.cgColor
            cell.timeAndDateText.text = (event.event_date ?? "") + "  ⎟  " + (event.event_time ?? "")
            cell.score.text = event.event_final_result
            return cell

        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.TEAMS_CELL, for: indexPath) as! TeamsCell
            
            let team = teamsList[indexPath.row]
            cell.teamImage.sd_setImage(with: URL(string:team.team_logo ?? " "), placeholderImage: UIImage(named: K.TEAMS_PLACEHOLDER_IMAGE))
            cell.teamName.text = team.team_name
      
            return cell
            
        }
  
    }
    
  
}

