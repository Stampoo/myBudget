//
//  TransactionTableViewCell.swift
//  myBudget
//
//  Created by fivecoil on 28/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class TransactionTableViewCell: UITableViewCell {

    //MARK: - Constants

    private enum Constants {
        static let inset: CGFloat = 5
        static let dateFormate = "EEEE, MMM d, yyyy"
    }


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
        let insets = UIEdgeInsets(top: Constants.inset,
                                  left: Constants.inset,
                                  bottom: Constants.inset,
                                  right: Constants.inset)
        contentView.frame = contentView.frame.inset(by: insets)
    }


    //MARK: - Public methods

    func configureCell(with transaction: Transaction) {
        targetLabel.text = transaction.name
        dateLabel.text = transaction.date.getFormattedDate(format: Constants.dateFormate)
        amountLabel.text = DoubleFormatter.shared.convertToString(from: transaction.amount)
    }
    
}
