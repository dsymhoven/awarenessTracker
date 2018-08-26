//
//  HistoryViewController.swift
//  AwarenessTracker
//
//  Created by David Symhoven on 25.08.18.
//  Copyright © 2018 David Symhoven. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var historyTableView: UITableView!
    
    // MARK:- Properties
    private var history: [Status]? {
        didSet {
            historyTableView.reloadData()
        }
    }
    
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        historyTableView.delegate = self
        historyTableView.dataSource = self
        
        PersistenceManager.fetchHistory { [weak self](success, history, error) in
            self?.history = history
        }
    }
}

// MARK:- Extensions
extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let history = history else {
            log.warning("history is not set yet in \(#function)")
            return 0
        }
        return history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.historyCellIdentifier, for: indexPath) as! HistoryTableViewCell
        guard let history = history else {
            log.warning("history not set yet in \(#function)")
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        }
        
        // TO DO: tight binding to data model. Fix this by using view models
        cell.setup(with: history[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
    
    
}
