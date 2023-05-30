//
//  APIHandlerProtocol.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 19/05/2023.
//

import Foundation
protocol NetworkManegerProtocol  {
    
    
    func getApiData<T: Decodable>(url: String, completionHandler: @escaping (Result<T, Error>) -> Void)
    
    
}
