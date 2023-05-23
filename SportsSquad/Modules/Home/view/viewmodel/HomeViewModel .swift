//
//  HomeViewModel .swift
//  SportsSquad
//
//  Created by Sara Eltlt on 23/05/2023.
//

import Foundation
import UIKit

class HomeViewModel {
    var isDarkMode: Bool {
        get {

            return UserDefaults.standard.bool(forKey: K.APPERANCE_MODE_KEY)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: K.APPERANCE_MODE_KEY)
            (UIApplication.shared.delegate as! AppDelegate).overrideApplicationThemeStyle()
        }
    }

    func getSportType(for tag: Int) -> String {
        switch tag {
        case 1: return "football"
        case 2: return "cricket"
        case 3: return "tennis"
        default: return "basketball"
        }
    }
}
