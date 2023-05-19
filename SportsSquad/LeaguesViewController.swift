//
//  LeaguesViewController.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 18/05/2023.
//

import UIKit

class LeaguesViewController: UIViewController {
    @IBOutlet weak var logoBtn: UIButton!
 
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var sportType : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate=self
        configNavigationBar()
    
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
            .font: UIFont(name: "Chalkduster", size: 20.0)!,
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.LEAGUES_CELL, for: indexPath) as! LeaguesTableViewCell
        

        cell.LeagueName.text = "Football League"
        cell.leagueImage.image = UIImage(named: K.LEAGUES_PLACEHOLDER_IMAGE)
        cell.layer.cornerRadius=40//try with different values untill u get the rounded corners
        cell.layer.masksToBounds=true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailsVC = self.storyboard!.instantiateViewController(withIdentifier: "detailsVC") as! ViewController
//        detailsVC.employee = empArray[indexPath.row]
//        self.navigationController?.pushViewController(detailsVC, animated: true)
        
    }
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
}


// MARK: - SearchBar
extension LeaguesViewController : UISearchBarDelegate{
    
}
