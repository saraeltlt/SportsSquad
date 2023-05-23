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
    
    func configure(with player: Player) {
         playerName.text = player.player_name
         playerType.text = player.player_type
         playerAge.text = player.player_age
         playerNumber.text = player.player_number
         playerImg.sd_setImage(with: URL(string: player.player_image ?? " "), placeholderImage: UIImage(named: K.Player_PLACEHOLDER_IMAGE))
     }
    override func awakeFromNib() {
        playerImg.layer.borderColor = UIColor(named: K.MEDIUM_PURPLE)?.cgColor
        self.layer.borderColor = UIColor(named: K.WHITE)?.cgColor
    }
 
}
