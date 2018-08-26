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
    
    static var status: Int?
    
    private static func todayDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: Date())
    }
    
    static func save(todaysStatus: Int) {
        
        let reference = Database.database().reference()
        let newChildRef = reference.child(todayDateString())
        let newAmountRef = newChildRef.child("amount")
        newAmountRef.setValue(todaysStatus)
    }
    
    static func getTodaysStatus(completion: @escaping (Bool, Int?, Error?) -> Void) {
        let reference = Database.database().reference()
        reference.observe(.value) {(snapshot) in
            for child in snapshot.children {
                if let childsnapshot = child as? DataSnapshot,
                    todayDateString() == childsnapshot.key,
                    let amount = childsnapshot.childSnapshot(forPath: "amount").value as? Int
                    {
                        status = amount
                        completion(true, amount, nil)
                }
            }
        }
    }
    
    
    static func deleteTodaysStatus() {
        Defaults[.todaysStatus] = 0
    }
    
    static func fetchHistory(completion: @escaping (Bool, [Status]?, Error?) -> Void) {
        var history = [Status]()
        let reference = Database.database().reference()
        reference.observe(.value) { (snapshot) in
            log.debug("Fetching history... Received snapshot: \(snapshot)")
            history.removeAll()
            for child in snapshot.children {
                if let childsnapshot = child as? DataSnapshot, let status = Status(with: childsnapshot) {
                    history.append(status)
                }
            }
            completion(true, history, nil)
        }
    }
}
