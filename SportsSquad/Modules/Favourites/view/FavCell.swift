//
//  FavCell.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 22/05/2023.
//

import UIKit

class FavCell: UITableViewCell {
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var bgView: UIView!
    let gradientLayer = CAGradientLayer()
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        teamImage.layer.borderColor = UIColor(named: K.WHITE)?.cgColor
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bgView.bounds
        let colorSet = [UIColor(named: K.BLUE)!,
                        UIColor(named:K.MEDIUM_PURPLE)!]
        let location = [0.2, 1.0]
        
        bgView.layer.insertSublayer(gradientLayer, at: 0)
        
        bgView.addGradient(with: gradientLayer, colorSet: colorSet, locations: location)
    }
    
    func configure(with team: Team) {
            teamImage.sd_setImage(with: URL(string: team.team_logo ?? ""), placeholderImage: UIImage(named: K.LEAGUES_PLACEHOLDER_IMAGE))
            teamName.text = team.team_name
        }


}

