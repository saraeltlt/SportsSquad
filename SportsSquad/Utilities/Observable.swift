//
//  Observable.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 29/05/2023.
//

import Foundation

class Observable<T> {

    var value: T? {
        didSet {
                self.listener?(self.value)
        }
    }
    
    init( _ value: T?) {
        self.value = value
    }
    
    private var listener: ((T?) -> Void)?
    
    func bind( _ listener: @escaping ((T?) -> Void)) {
        listener(value)
        self.listener = listener
    }
}
