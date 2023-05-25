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
        noSearchResult.isHidden = true
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        configNavigationBar()
        if !NetworkStatusChecker.isInternetAvailable() {
            showToast(text: "No Internet Connection", imageName: K.NO_WIFI)
        }
        
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
                self?.updateNoSearchResultVisibility()
            }
        }
        
        leaguesViewModel.getLeaguesAPI()
        
   
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
    
    private func updateNoSearchResultVisibility() {
        if leaguesViewModel.numberOfLeagues == 0 {
            noSearchResult.isHidden = false
        } else {
            noSearchResult.isHidden = true
        }
    }
}

