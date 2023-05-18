//
//  LeaguesViewController.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 18/05/2023.
//

import UIKit

class LeaguesViewController: UIViewController {
    @IBOutlet weak var logoBtn: UIButton!
 
    var sportType : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        logoBtn.layer.cornerRadius = logoBtn.frame.size.width / 2


    }
    

    @IBAction func logoPressed(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }

}
