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

    override func layoutSubviews() {
        super.layoutSubviews()
        frame = frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
    }


    //MARK: - Public methods

    func configureCell(with transaction: Transaction) {
        targetLabel.text = transaction.name
        dateLabel.text = transaction.date.getFormattedDate(format: "EEEE, MMM d, yyyy")
        amountLabel.text = DoubleFormatter.shared.convertToString(from: transaction.amount)
    }
    
}
