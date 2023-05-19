//
//  Extensions.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 18/05/2023.
//

import Foundation
import UIKit
//MARK: - change mood
extension AppDelegate {
    func overrideApplicationThemeStyle() {
        if #available(iOS 13.0, *) {
            let isDarkMode = UserDefaults.standard.bool(forKey: K.APPERANCE_MODE_KEY)
            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        } else {
            // Fallback on earlier versions
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

