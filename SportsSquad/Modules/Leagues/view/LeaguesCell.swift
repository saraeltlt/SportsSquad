//
//  LeaguesTableViewCell.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 19/05/2023.
//
import UIKit

class LeaguesCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var LeagueName: UILabel!
    @IBOutlet weak var leagueImage: UIImageView!
    let gradientLayer = CAGradientLayer()

    override func awakeFromNib() {
        super.awakeFromNib()
        leagueImage.layer.borderColor = UIColor(named: K.WHITE)?.cgColor
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

}
