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
    @IBOutlet weak var networkIndecator: UIActivityIndicatorView!
    

    var leaguesViewModel: LeaguesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundView?.backgroundColor = UIColor.clear
        searchBar.delegate = self
        configNavigationBar()
        
        leaguesViewModel?.bindNetworkIndicator = { [weak self] isLoading in
              DispatchQueue.main.async {
                  if isLoading {
                      self?.networkIndecator.startAnimating()
                  } else {
                      self?.networkIndecator.stopAnimating()
                  }
              }
          }
        
        leaguesViewModel?.bindListToLeagueTableViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        leaguesViewModel.getLeaguesAPI()
        
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
    }
  
//MARK: - handle back navigation
private func configNavigationBar() {
        // Edit back button
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: K.BACK_ARROW), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        // Edit title
        let textAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(named: K.DARK_PURPLE)!,
            .font: UIFont(name: "Chalkduster", size: 17.0)!,
        ]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
       self.title = "\(leaguesViewModel.getSportType()) leagues"
    }
    
    @IBAction func logoPressed(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}


//MARK: - Table View Controller
extension LeaguesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaguesViewModel.numberOfLeagues
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.LEAGUES_CELL, for: indexPath) as! LeaguesCell
        let league = leaguesViewModel.getLeague(at: indexPath.row)
        
        cell.LeagueName.text = league.league_name
        cell.leagueImage.sd_setImage(with: URL(string: league.league_logo), placeholderImage: UIImage(named: K.LEAGUES_PLACEHOLDER_IMAGE))
        cell.layer.cornerRadius = 40 
        cell.layer.masksToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leagueId = leaguesViewModel!.getLeague(at: indexPath.row).league_key
        let leagueName = leaguesViewModel!.getLeague(at: indexPath.row).league_name
        let sportType = leaguesViewModel.getSportType()
        let detailsVC = self.storyboard!.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as! LeagueDetailsViewController
        let detailsViewModel = LeagueDetailsViewModel(leagueId: leagueId, leagueName: leagueName, sportType: sportType)
        detailsVC.detailsViewModel = detailsViewModel
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


//MARK: - search bar
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
}
