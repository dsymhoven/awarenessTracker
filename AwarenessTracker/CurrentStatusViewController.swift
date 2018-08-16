//
//  CurrentStatusViewController.swift
//  AwarenessTracker
//
//  Created by David Symhoven on 16.08.18.
//  Copyright © 2018 David Symhoven. All rights reserved.
//

import UIKit

class CurrentStatusViewController: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak var currentStatusLabel: UILabel!
    
    // MARK:- Actions
    @IBAction func awarenessButtonPressed(_ sender: UIButton) {
        let todaysStatus = PersistenceManager.getTodaysStatus()
        PersistenceManager.save(todaysStatus: todaysStatus + 1)
        updateStatusLabel()
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        PersistenceManager.deleteTodaysStatus()
        updateStatusLabel()
    }
    
    // MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateStatusLabel), name: .UIApplicationWillEnterForeground, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK:- User methods
    private func setupUI() {
        updateStatusLabel()
    }
    
    @objc private func updateStatusLabel() {
        currentStatusLabel.text = "\(PersistenceManager.getTodaysStatus())"
    }
}
