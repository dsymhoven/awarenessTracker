//
//  HistoryTableViewCell.swift
//  AwarenessTracker
//
//  Created by David Symhoven on 26.08.18.
//  Copyright © 2018 David Symhoven. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    // MARK:- Outlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    // MARK:- UI
    func setup(with status: Status) {
        dateLabel.text = status.timestamp!
        statusLabel.text = "\(status.amount!)"
    }
}
