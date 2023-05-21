//
//  NetworkStatusChecker.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 19/05/2023.
//

import Foundation
import Reachability

class NetworkStatusChecker {
    static var reachabilityInstance: Reachability?
    static func isInternetAvailable() -> Bool {
        let reachability = try? reachabilityInstance ?? Reachability()
        return reachability?.connection != .unavailable
    }
}

