//
//  Extensions.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 18/05/2023.
//

import Foundation
import UIKit
extension AppDelegate {
    func overrideApplicationThemeStyle() {
        if #available(iOS 13.0, *) {
            let isDarkMode = UserDefaults.standard.bool(forKey: K.appearanceModeKey)
            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        } else {
            // Fallback on earlier versions
        }
    }
}
