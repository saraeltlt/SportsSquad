//
//  UpcomingEventsCollectionViewCell.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 19/05/2023.
//

import UIKit

class UpcomingEventsCell: UICollectionViewCell {
    let gradientLayer = CAGradientLayer()
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var awayTeamName: UILabel!
    @IBOutlet weak var awayTeamLogo: UIImageView!
    @IBOutlet weak var homeTeamLogo: UIImageView!
    @IBOutlet weak var homeTeamName: UILabel!
    @IBOutlet weak var timeAndDateText: UITextField!
    
    override func layoutSublayers(of layer: CALayer) {
        gradientLayer.frame = bgView.bounds
        let colorSet = [UIColor(named: K.BLUE)!,
                        UIColor(named:K.MEDIUM_PURPLE)!]
        let location = [0.2, 1.0]
        
        bgView.layer.insertSublayer(gradientLayer, at: 0)
        
        bgView.addGradient(with: gradientLayer, colorSet: colorSet, locations: location)
    }
    
}

