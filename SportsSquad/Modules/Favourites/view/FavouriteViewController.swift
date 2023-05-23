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
        viewModel.bindFavListToFavouriteTableViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.favTableView.reloadData()
            }
        }
        viewModel.fetchTeams()
        setupAnimation()
    }

    private func setupAnimation() {
        animationView.isHidden = viewModel.teamsCount > 0
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
        let detailsVC = self.storyboard!.instantiateViewController(withIdentifier: "TeamsDetailsViewController") as! TeamsDetailsViewController
        let team = viewModel.team(at: indexPath.row)
        let teamViewModel = TeamDetailsViewModel(teamId: team.team_key!, teamName: team.team_name!)
        detailsVC.viewModel = teamViewModel
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            self?.viewModel.deleteTeam(at: indexPath.row)
            completionHandler(true)
        }

        deleteAction.backgroundColor = UIColor(named: K.MEDIUM_PURPLE)

        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}

