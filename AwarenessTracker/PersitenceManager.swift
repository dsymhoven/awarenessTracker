//
//  PersitenceManager.swift
//  AwarenessTracker
//
//  Created by David Symhoven on 16.08.18.
//  Copyright © 2018 David Symhoven. All rights reserved.
//

import Foundation
import SwiftyUserDefaults
import FirebaseDatabase

class PersistenceManager {
    
    static func save(todaysStatus: Int) {
        Defaults[.todaysStatus] = todaysStatus
    }
    
    static func getTodaysStatus() -> Int {
        let reference = Database.database().reference()
        reference.observe(.value) { (snapshot) in
            log.debug(snapshot)
        }
        return Defaults[.todaysStatus]
    }
    
    static func deleteTodaysStatus() {
        Defaults[.todaysStatus] = 0
    }
}
