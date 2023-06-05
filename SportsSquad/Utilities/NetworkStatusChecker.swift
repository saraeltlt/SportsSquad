import Foundation
import Reachability

class NetworkStatusChecker {
    static var reachabilityInstance: Reachability?
    static func isInternetAvailable() -> Bool {
        let reachability = try? reachabilityInstance ?? Reachability()
        return reachability?.connection != .unavailable
    }
}

