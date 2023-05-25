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
    @IBOutlet weak var landScapeView: UIView!
    @IBOutlet weak var portraitView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        homeViewModel = HomeViewModel()
        switchMode.isOn = homeViewModel.isDarkMode
        modeLabel.text = homeViewModel.isDarkMode ? "Dark Mode" : "Light Mode"

    }
    override func viewDidAppear(_ animated: Bool) {
        updateOrientation()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        updateOrientation()
    }
    
    private func updateOrientation() {
        
        if UIDevice.current.orientation.isLandscape {
            portraitView.isHidden=true
            landScapeView.isHidden=false
        }else{
            portraitView.isHidden=false
            landScapeView.isHidden=true
        }
    }
    
    
    @IBAction func sportPressed(_ sender: UIButton) {
        if NetworkStatusChecker.isInternetAvailable() {
            let leaguesVC = storyboard!.instantiateViewController(withIdentifier: "LeaguesViewController") as! LeaguesViewController
            leaguesVC.leaguesViewModel = homeViewModel.navigationConfig(for: sender.tag)
            navigationController?.pushViewController(leaguesVC, animated: true)
        }else{
            showNoInternetAlert()
        }
    }

    @IBAction func modeChanged(_ sender: UISwitch) {
        homeViewModel.isDarkMode = sender.isOn
        modeLabel.text = homeViewModel.isDarkMode ? "Dark Mode" : "Light Mode"
    }
}
