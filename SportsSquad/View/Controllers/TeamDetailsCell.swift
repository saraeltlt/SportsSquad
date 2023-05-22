//
//  TeamDetailsCell.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 21/05/2023.
//

import UIKit

class TeamDetailsCell: UICollectionViewCell {
    @IBOutlet weak var playerAge: UILabel!
    @IBOutlet weak var playerNumber: UILabel!
    @IBOutlet weak var playerType: UILabel!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerImg: UIImageView!
    

    override func awakeFromNib() {
        playerImg.layer.borderColor = UIColor(named: K.MEDIUM_PURPLE)?.cgColor
        self.layer.borderColor = UIColor(named: K.WHITE)?.cgColor
    }
 
}
