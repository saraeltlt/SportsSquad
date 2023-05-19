//
//  LeaguesTableViewCell.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 19/05/2023.
//
import UIKit

class LeaguesTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var LeagueName: UILabel!
    @IBOutlet weak var leagueImage: UIImageView!
    let gradientLayer = CAGradientLayer()

    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 40
        bgView.layer.masksToBounds = true
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
