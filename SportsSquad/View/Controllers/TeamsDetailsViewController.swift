//
//  TeamsDetailsViewController.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 21/05/2023.
//

import UIKit
import SDWebImage

class TeamsDetailsViewController: UIViewController {

    @IBOutlet weak var playersCollectionView: UICollectionView!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var coachNameBtn: UIButton!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamLogo: UIImageView!
    var teamId : Int = 0
    var isFav  = false
    var team = Teams()
    var teamNameText = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        playersCollectionView.delegate = self
        playersCollectionView.dataSource = self
        playersCollectionView.backgroundView?.backgroundColor = UIColor.clear
       playersCollectionView.backgroundColor = UIColor.clear

        APIHandler.sharedInstance.getTeamDetails(teamId: teamId) { players in
            self.team = players.result[0]
            DispatchQueue.main.async {
                self.playersCollectionView.reloadData()
                self.teamLogo.sd_setImage(with: URL(string:self.team.team_logo ?? " "), placeholderImage: UIImage(named: K.LEAGUES_PLACEHOLDER_IMAGE))
                self.teamName.text = self.team.team_name
                self.coachNameBtn.setTitle("  \(self.team.coaches[0].coach_name ?? "unknown")", for: .normal)
            }
            
        }
        
       
        
        
        let layout = UICollectionViewCompositionalLayout{
            index, enviroment in
            return self.playersSection()
        }
        playersCollectionView.setCollectionViewLayout(layout, animated: true)

    }
    // MARK: - add to favourite
    @IBAction func addToFav(_ sender: Any) {
        if (!isFav){
            favBtn.tintColor = UIColor(named: K.favColor)
            DataBaseManeger.shared().saveData(teamData: team)
            isFav=true
        }
        else{
            favBtn.tintColor = UIColor(named: K.WHITE)
            DataBaseManeger.shared().deleteData(teamId: teamId)
            isFav = false
        }
    }
    // MARK: - Latest events
    func playersSection() -> NSCollectionLayoutSection{
        //section consists of group of items......
        
        //item
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)))
        item.contentInsets  = NSDirectionalEdgeInsets(top: 5, leading: 8, bottom: 5, trailing: 8)
        
        
        //group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(240)), subitems: [item])
        group.contentInsets  = NSDirectionalEdgeInsets(top: 5, leading: 8, bottom: 5, trailing: 8)
        
        
        //section
        let section = NSCollectionLayoutSection(group: group)

        
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
                .foregroundColor: UIColor(named: K.MEDIUM_PURPLE)!,
                .font: UIFont(name: "Chalkduster", size: 17.0)!,
            ]
            navigationController?.navigationBar.titleTextAttributes = textAttributes
            navigationItem.title = teamNameText
        }
        @objc func backButtonTapped() {
            self.navigationController?.popViewController(animated: true)
        }
        


}
    
// MARK: - UICollectionView
extension TeamsDetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let teamPlayers = team.players{
            return teamPlayers.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.TEAM_DETAILS_CELL, for: indexPath) as! TeamDetailsCell
        
        cell.playerName.text = team.players![indexPath.row].player_name
        cell.playerType.text = team.players![indexPath.row].player_type
        cell.playerAge.text = team.players![indexPath.row].player_age
        cell.playerNumber.text = team.players![indexPath.row].player_number
        cell.playerImg.sd_setImage(with: URL(string: team.players![indexPath.row].player_image ?? " "), placeholderImage: UIImage(named: K.Player_PLACEHOLDER_IMAGE))
       
        
        let existingColor = UIColor(named: K.WHITE)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        existingColor!.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        cell.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 0.5)
        return cell
    }
    
}
