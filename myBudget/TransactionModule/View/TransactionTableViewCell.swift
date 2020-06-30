//
//  TransactionTableViewCell.swift
//  myBudget
//
//  Created by fivecoil on 28/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class TransactionTableViewCell: UITableViewCell {

    //MARK: - IBOutlets

    @IBOutlet private weak var amountLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var targetLabel: UILabel!


    //MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }


    //MARK: - Public methods

    func configureCell(with transaction: Transaction) {
        targetLabel.text = transaction.name
        dateLabel.text = transaction.date.getFormattedDate(format: "EEEE, MMM d, yyyy")
        amountLabel.text = "\(transaction.amount)"
    }
    
}
