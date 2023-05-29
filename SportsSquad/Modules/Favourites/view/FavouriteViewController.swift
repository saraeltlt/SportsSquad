//
//  FavouriteViewController.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 19/05/2023.
//

import UIKit
import Lottie

class FavouriteViewController: UIViewController {

    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var noFavLabel: UILabel!
    @IBOutlet weak var favTableView: UITableView!

    var viewModel: FavouriteViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FavouriteViewModel()
        favTableView.delegate = self
        favTableView.dataSource = self
        setupAnimation()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.bindFavListToFavouriteTableViewController.bind {  [weak self] isLoading in
            if let _ = isLoading{
                DispatchQueue.main.async {
                    self?.favTableView.reloadData()
                }
            }
        }

        viewModel.fetchTeams()
        setupAnimation()
    }

    private func setupAnimation() {
        if viewModel.teamsCount <= 0{
            animationView.isHidden=false
            noFavLabel.isHidden=false
             animationView.loopMode = .loop
             animationView.play()
        }else{
            animationView.isHidden=true
            noFavLabel.isHidden=true
            animationView.stop()
        }
    }
}

// MARK: - TableView

extension FavouriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.teamsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.FAVOURITE_CELL, for: indexPath) as! FavCell
        let team = viewModel.team(at: indexPath.row)
        cell.configure(with: team)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.isInternetAvailable() {
            
            let detailsVC = self.storyboard!.instantiateViewController(withIdentifier: "TeamsDetailsViewController") as! TeamsDetailsViewController
        
            detailsVC.viewModel = viewModel.navigationConfig(for: indexPath.row)
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }else{
            showNoInternetAlert()
        }
    }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }
        
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
                self?.confirmDeleteAlert {
                    self?.viewModel.deleteTeam(at: indexPath.row)
                    completionHandler(true)
                    self?.setupAnimation()
                }
            
            }
            
            deleteAction.backgroundColor = UIColor(named: K.MEDIUM_PURPLE)
            
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            return configuration
        }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        cell.layer.transform = rotationTransform
        cell.alpha=0
        UIView.animate(withDuration: 0.5) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha=1.0
        
        }
    }
    }
    

