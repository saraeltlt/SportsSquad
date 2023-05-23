//
//  FavouriteViewController.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 19/05/2023.
//

import UIKit
import Lottie
class FavouriteViewController: UIViewController {

    

    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var favTableView: UITableView!
    var teamsList = [Teams]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favTableView.delegate = self
        favTableView.dataSource = self
        DataBaseManeger.shared().getData(teamsList: &teamsList)
        favTableView.reloadData()
        setupAnimation()
        
        

    }
    override func viewWillAppear(_ animated: Bool) {
        DataBaseManeger.shared().getData(teamsList: &teamsList)
        favTableView.reloadData()
        setupAnimation()
    }
    
    //MARK: - NO Favourite animation View
    private func setupAnimation(){
    animationView.isHidden = !teamsList.isEmpty
      
        
    }
    
    
    


}
//MARK: - TableView
extension FavouriteViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.FAVOURITE_CELL, for: indexPath) as! FavCell
        cell.teamImage.sd_setImage(with: URL(string: teamsList[indexPath.row].team_logo ?? ""), placeholderImage: UIImage(named: K.LEAGUES_PLACEHOLDER_IMAGE))
        cell.teamName.text = teamsList[indexPath.row].team_name
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

     let detailsVC = self.storyboard!.instantiateViewController(withIdentifier: "TeamsDetailsViewController") as! TeamsDetailsViewController
        detailsVC.teamId = teamsList[indexPath.row].team_key!
        detailsVC.teamNameText = teamsList[indexPath.row].team_name!
        detailsVC.isFav = true
        self.navigationController?.pushViewController(detailsVC, animated: true)
        
    }
   
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 100
   }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completionHandler) in
            DataBaseManeger.shared().deleteData(teamId: self.teamsList[indexPath.row].team_key ?? 0)
            self.teamsList.remove(at:indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            completionHandler(true)
        }

        deleteAction.backgroundColor = UIColor(named: K.MEDIUM_PURPLE)
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
}

