//
//  Status.swift
//  AwarenessTracker
//
//  Created by David Symhoven on 18.08.18.
//  Copyright © 2018 David Symhoven. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Status {
    
    enum JSONKeys {
        static let amount = "amount"
    }

    let amount: Int?
    
    init?(with snapshot: DataSnapshot) {
        
        guard let dict = snapshot.value as? [String: AnyObject] else {
            log.error("can not initialize Status object with snapshot")
            return nil
        }
        amount = Int(jsonData: dict[JSONKeys.amount])
    }
    
    init(timestamp: Int64, amount: Int) {
        self.amount = amount
    }
}

extension Int {
    init?(jsonData: AnyObject?) {
        if let number = jsonData as? Int {
            self = number
        } else {
            return nil
        }
    }
}

extension Int64 {
    init?(jsonData: AnyObject?) {
        if let number = jsonData as? Int64 {
            self = number
        } else {
            return nil
        }
    }
}
