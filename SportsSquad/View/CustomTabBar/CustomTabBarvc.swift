//
//  CustomTabBarvc.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 25/05/2023.
//

import UIKit
class CustomTabBarvc: UITabBarController, UITabBarControllerDelegate {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.selectedIndex = 0
        setupMiddleButton()
    }
    
    func setupMiddleButton() {
        let middleButtonSize: CGFloat = self.tabBar.frame.height*1.45
        let bottomMargin: CGFloat = 30
        
        let middleButton = UIButton()
        middleButton.translatesAutoresizingMaskIntoConstraints = false
        middleButton.setBackgroundImage(UIImage(named: "Logo"), for: .normal)
        //middleButton.layer.shadowColor = UIColor.black.cgColor
        middleButton.layer.shadowOpacity = 0.1
        middleButton.layer.backgroundColor = UIColor.clear.cgColor
        middleButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        
        self.tabBar.addSubview(middleButton)
        
        NSLayoutConstraint.activate([
            middleButton.centerXAnchor.constraint(equalTo: self.tabBar.centerXAnchor, constant: 6),
            middleButton.bottomAnchor.constraint(equalTo: self.tabBar.bottomAnchor, constant: -bottomMargin),
            middleButton.widthAnchor.constraint(equalToConstant: middleButtonSize),
            middleButton.heightAnchor.constraint(equalToConstant: middleButtonSize)
        ])
    }
}
