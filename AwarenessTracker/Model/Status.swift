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
    let timestamp: String?
    
    init?(with snapshot: DataSnapshot) {
        
        guard let dict = snapshot.value as? [String: AnyObject] else {
            log.error("can not initialize Status object with snapshot")
            return nil
        }
        
        timestamp = snapshot.key
        amount = Int(jsonData: dict[JSONKeys.amount])
    }
    
    init(timestamp: String, amount: Int) {
        self.amount = amount
        // TO DO: not type safe. Fix this
        self.timestamp = timestamp
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
