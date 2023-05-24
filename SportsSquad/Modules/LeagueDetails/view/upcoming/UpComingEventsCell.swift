//
//  UpComingEventsCell.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 20/05/2023.
//

import UIKit

class UpComingEventsCell: UICollectionViewCell {
    let gradientLayer = CAGradientLayer()
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var awayTeamName: UILabel!
    @IBOutlet weak var awayTeamLogo: UIImageView!
    @IBOutlet weak var homeTeamLogo: UIImageView!
    @IBOutlet weak var homeTeamName: UILabel!
    @IBOutlet weak var timeAndDateText: UILabel!
    
    func configure(with event: UpComingStructView) {
         awayTeamName.text = event.event_away_team
         homeTeamName.text = event.event_home_team
         awayTeamLogo.sd_setImage(with: URL(string: event.away_team_logo ?? ""), placeholderImage: UIImage(named: K.LEAGUES_PLACEHOLDER_IMAGE))
         homeTeamLogo.sd_setImage(with: URL(string: event.home_team_logo ?? ""), placeholderImage: UIImage(named: K.LEAGUES_PLACEHOLDER_IMAGE))
         timeAndDateText.layer.borderColor = UIColor(named: K.WHITE)?.cgColor
         timeAndDateText.text = "\(event.event_date ?? "")  ⎟  \(event.event_time ?? "")"
     }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSublayers(of layer: CALayer) {
        gradientLayer.frame = bgView.bounds
        let colorSet = [UIColor(named: K.BLUE)!,
                        UIColor(named:K.MEDIUM_PURPLE)!]
        let location = [0.2, 1.0]
        
        bgView.layer.insertSublayer(gradientLayer, at: 0)
        
        bgView.addGradient(with: gradientLayer, colorSet: colorSet, locations: location)
    }
    

}
