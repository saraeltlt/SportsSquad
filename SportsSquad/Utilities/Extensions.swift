//
//  Extensions.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 18/05/2023.
//

import Foundation
import UIKit
import SwiftToast
//MARK: - change mood
extension AppDelegate {
    func overrideApplicationThemeStyle() {
        if #available(iOS 13.0, *) {
            let isDarkMode = UserDefaults.standard.bool(forKey: K.APPERANCE_MODE_KEY)
            let appearanceMode: UIUserInterfaceStyle = isDarkMode ? .dark : .light
            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = appearanceMode
        } else {
            let isDarkMode = UserDefaults.standard.bool(forKey: K.APPERANCE_MODE_KEY)
            UIApplication.shared.statusBarStyle = isDarkMode ? .lightContent : .default
        }
    }
}

//MARK: - gradient Background
extension UIView {
    func addGradient(with layer: CAGradientLayer, gradientFrame: CGRect? = nil, colorSet: [UIColor],
                     locations: [Double], startEndPoints: (CGPoint, CGPoint)? = nil) {
        layer.frame = gradientFrame ?? self.bounds
        layer.frame.origin = .zero
        
        let layerColorSet = colorSet.map { $0.cgColor }
        let layerLocations = locations.map { $0 as NSNumber }
        
        layer.colors = layerColorSet
        layer.locations = layerLocations
        
        if let startEndPoints = startEndPoints {
            layer.startPoint = startEndPoints.0
            layer.endPoint = startEndPoints.1
        }
        
        self.layer.insertSublayer(layer, above: self.layer)
    }
}

    //MARK: - Custom alert
extension UIViewController {
    func showNoInternetAlert() {
        let alert = UIAlertController(title:"No internet connection" , message: "Please check your wifi or celluar data and try again", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    func showNoConnectionToast(){
        let toast =  SwiftToast(
                            text: "No internet connection",
                            textAlignment: .center,
                            image: UIImage(named: K.NO_WIFI),
                            backgroundColor: UIColor(named:  K.LIGHT_PURPLE),
                            textColor:UIColor(named: K.DARK_PURPLE),
                            font: UIFont(name: "Chalkduster", size: 23.0),
                            duration: 2.0,
                            minimumHeight: CGFloat(100.0),
                            statusBarStyle: .default,
                            aboveStatusBar: false,
                            target: nil,
                            style: .bottomToTop)
        present(toast, animated: true)
    
      
    }
}
