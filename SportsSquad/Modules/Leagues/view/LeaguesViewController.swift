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






