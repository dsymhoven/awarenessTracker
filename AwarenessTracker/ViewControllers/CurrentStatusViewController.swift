//
//  CurrentStatusViewController.swift
//  AwarenessTracker
//
//  Created by David Symhoven on 16.08.18.
//  Copyright © 2018 David Symhoven. All rights reserved.
//

import UIKit

class CurrentStatusViewController: UIViewController {

    // MARK:- Properties
    private var status = 0
    
    // MARK:- Outlets
    @IBOutlet weak var currentStatusLabel: UILabel!
    
    // MARK:- Actions
    @IBAction func awarenessButtonPressed(_ sender: UIButton) {
        PersistenceManager.save(todaysStatus: status + 1)
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        PersistenceManager.save(todaysStatus: 0)
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
        PersistenceManager.getTodaysStatus(completion: { [weak self] (success, amount, error) in
            guard let amount = amount else {
                log.warning("no status found for today")
                return
            }
            self?.status = amount
            self?.currentStatusLabel.text = "\(amount)"
        })
    }
}
