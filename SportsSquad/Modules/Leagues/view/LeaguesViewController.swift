//
//  LeaguesViewController.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 18/05/2023.
//

import UIKit
import SDWebImage


class LeaguesViewController: UIViewController{
    @IBOutlet weak var noSearchResult: UIImageView!
    @IBOutlet weak var logoBtn: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var sportType : String!
    var leaguesArray = [League]()
    var isSearching = false
    var searchArray = [League]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
           view.addGestureRecognizer(tapGesture)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundView?.backgroundColor = UIColor.clear
        tableView.backgroundColor = UIColor.clear
        searchBar.delegate=self
        configNavigationBar()
        APIHandler.sharedInstance.getLeagues(sportType: sportType) { leagues in
            self.leaguesArray = leagues.result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        searchBar.barTintColor = UIColor.clear
        searchBar.backgroundColor = UIColor.clear
        searchBar.isTranslucent = true
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
    
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
        self.title = "\(sportType!) leagues"
    }
    @IBAction func logoPressed(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - table view
extension LeaguesViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (isSearching){
           noSearchResult.isHidden = !searchArray.isEmpty
             return searchArray.count
        }
        return leaguesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.LEAGUES_CELL, for: indexPath) as! LeaguesCell
        var league : League!
        if (isSearching){
            league = searchArray[indexPath.row]
            
        }else{
           league = leaguesArray[indexPath.row]
        }

        cell.LeagueName.text = league.league_name
        cell.leagueImage.sd_setImage(with: URL(string:league.league_logo ?? " "), placeholderImage: UIImage(named: K.LEAGUES_PLACEHOLDER_IMAGE))
        cell.layer.cornerRadius=40//try different values
        cell.layer.masksToBounds=true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var league : League!
        if (isSearching){
            league = searchArray[indexPath.row]
            
        }else{
           league = leaguesArray[indexPath.row]
        }
     let detailsVC = self.storyboard!.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as! LeagueDetailsViewController
        detailsVC.leagueDetails = league
        detailsVC.sportType = sportType
        self.navigationController?.pushViewController(detailsVC, animated: true)
        
    }
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
}


// MARK: - SearchBar
extension LeaguesViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == ""{
            isSearching=false
            noSearchResult.isHidden = true
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
        else{
            isSearching=true
            searchArray = leaguesArray.filter { $0.league_name!.lowercased().contains(searchBar.text?.lowercased() ?? "") }

        }
        tableView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != nil || searchBar.text != "" {
            isSearching=true
            searchArray = leaguesArray.filter { $0.league_name!.lowercased().contains(searchBar.text?.lowercased() ?? "") }
        }
        searchBar.resignFirstResponder()
    }
    @objc func handleTap() {
        
        searchBar.resignFirstResponder()
    }
  
}
