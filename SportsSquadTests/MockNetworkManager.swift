//
//  MockNetworkManager.swift
//  SportsSquadTests
//
//  Created by Sara Eltlt on 29/05/2023.
//

import Foundation
class MockNetworkManager : NetworkManagerProtocol {
    var shouldReturnError: Bool
    init(shouldReturnError : Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    func getData( completionHandler complitionHandler: @escaping ([Item]?, Error?) -> Void) {
        do{
            if shouldReturnError{
                let jsonData = try loadJSON(filename: "INVALID_NAME", type: ItemModel.self)
            }
            else{
                let jsonData = try loadJSON(filename: "MoviesResponse", type: ItemModel.self)
                complitionHandler(jsonData.items,nil)
            }
            
        } catch MockableError.failedToDecodeJSON {
            complitionHandler(nil, MockableError.failedToDecodeJSON)
        } catch {
            complitionHandler(nil, MockableError.failedToLoadJSON)
        }
        
    }
    
    
}
