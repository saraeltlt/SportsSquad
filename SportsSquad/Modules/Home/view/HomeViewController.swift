//
//  HomeViewController.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 18/05/2023.
//

import UIKit


class HomeViewController: UIViewController {
    var homeViewModel: HomeViewModel!

    @IBOutlet weak var footballBtn: UIButton!
    @IBOutlet weak var modeLabel: UILabel!
    @IBOutlet weak var switchMode: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()

        homeViewModel = HomeViewModel()
        switchMode.isOn = homeViewModel.isDarkMode
        modeLabel.text = homeViewModel.isDarkMode ? "Dark Mode" : "Light Mode"
    }

    @IBAction func sportPressed(_ sender: UIButton) {
        let leaguesVC = storyboard!.instantiateViewController(withIdentifier: "LeaguesViewController") as! LeaguesViewController
        let sportType = homeViewModel.getSportType(for: sender.tag)
        let leagueViewModel = LeaguesViewModel(sportType: sportType)
        leaguesVC.leaguesViewModel = leagueViewModel
        navigationController?.pushViewController(leaguesVC, animated: true)
    }

    @IBAction func modeChanged(_ sender: UISwitch) {
        homeViewModel.isDarkMode = sender.isOn
        modeLabel.text = homeViewModel.isDarkMode ? "Dark Mode" : "Light Mode"
    }
}
