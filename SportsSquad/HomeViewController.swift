//
//  HomeViewController.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 18/05/2023.
//

import UIKit

class HomeViewController: UIViewController, UIViewControllerTransitioningDelegate {
    var isDarkMode: Bool = false
    @IBOutlet weak var footballBtn: UIButton!
    let transition = CircularTransition()
    
    
    @IBOutlet weak var modeLabel: UILabel!
    
    @IBOutlet weak var switchMode: UISwitch!{
        didSet{
            switchMode.onTintColor = UIColor(named: "MidumPurple")
            switchMode.tintColor =  UIColor(named: "MidumPurple")
            switchMode.subviews[0].subviews[0].backgroundColor =  UIColor(named: "MidumPurple")
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isDarkMode = UserDefaults.standard.bool(forKey: K.appearanceModeKey)
        switchMode.isOn = isDarkMode
        modeLabel.text = isDarkMode ? "Dark Mode" : "Light Mode"
        footballBtn.layer.cornerRadius = footballBtn.frame.size.width / 2
 
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let leaguesVC = segue.destination as! LeaguesViewController
        leaguesVC.transitioningDelegate = self
        leaguesVC.modalPresentationStyle = .custom
    }
    
    @IBAction func sportPressed(_ sender: UIButton) {
        let leaguesVC = self.storyboard!.instantiateViewController(withIdentifier: "LeaguesViewController") as! LeaguesViewController
        switch (sender.tag){
        case 1: //Football
            leaguesVC.sportType="football"
        case 2: //Cricket
            leaguesVC.sportType="cricket"
        case 3: //Tennis
            leaguesVC.sportType="tennis"
        default: //4: Basketball
            leaguesVC.sportType="basketball"
        }
        /*leaguesVC.transitioningDelegate = self
        leaguesVC.modalPresentationStyle = .custom
        self.navigationController?.pushViewController( leaguesVC, animated: true)*/
    }
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = footballBtn.center
        transition.circleColor = footballBtn.backgroundColor!
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = footballBtn.center
        transition.circleColor = footballBtn.backgroundColor!
        
        return transition
    }
    
    
    @IBAction func modeChanged(_ sender: UISwitch) {
        isDarkMode = sender.isOn
        modeLabel.text = isDarkMode ? "Dark Mode" : "Light Mode"
        UserDefaults.standard.set(isDarkMode, forKey: K.appearanceModeKey)
        (UIApplication.shared.delegate as! AppDelegate).overrideApplicationThemeStyle()
        
        
    }

    
}

