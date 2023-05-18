//
//  HomeViewController.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 18/05/2023.
//

import UIKit

class HomeViewController: UIViewController {
    var isDarkMode: Bool = false
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
        setAppearanceMode(isDarkMode)
        switchMode.isOn = isDarkMode
        modeLabel.text = isDarkMode ? "Dark Mode" : "Light Mode"
 
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
        self.navigationController?.pushViewController( leaguesVC, animated: true)
    }
    
    
    @IBAction func modeChanged(_ sender: UISwitch) {
               isDarkMode = sender.isOn
        modeLabel.text = isDarkMode ? "Dark Mode" : "Light Mode"

               setAppearanceMode(isDarkMode)
        UserDefaults.standard.set(isDarkMode, forKey: K.appearanceModeKey)
        
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
          super.traitCollectionDidChange(previousTraitCollection)
          if traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle {
              setAppearanceMode(isDarkMode)
              UserDefaults.standard.set(isDarkMode, forKey: K.appearanceModeKey)
          }
      }
    
    func setAppearanceMode(_ isDarkMode: Bool) {
         overrideUserInterfaceStyle = isDarkMode ? .dark : .light
     }
    
}

