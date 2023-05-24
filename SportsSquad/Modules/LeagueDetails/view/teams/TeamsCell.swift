//
//  TeamsCell.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 20/05/2023.
//

import UIKit

class TeamsCell: UICollectionViewCell {

    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    func configure(with team: TeamsStructView, sportType:String) {
        if (sportType == K.sportsType.tennis.rawValue){
            teamImage.sd_setImage(with: URL(string: team.team_logo ?? ""), placeholderImage: UIImage(named: K.Player_PLACEHOLDER_IMAGE))
        }else{
            teamImage.sd_setImage(with: URL(string: team.team_logo ?? ""), placeholderImage: UIImage(named: K.TEAMS_PLACEHOLDER_IMAGE))
        }
        
            teamName.text = team.team_name
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
