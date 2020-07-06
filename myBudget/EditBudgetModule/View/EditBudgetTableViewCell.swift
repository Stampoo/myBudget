//
//  EditBudgetTableViewCell.swift
//  myBudget
//
//  Created by fivecoil on 06/07/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class EditBudgetTableViewCell: UITableViewCell {


    //MARK: - Constants

    private enum Constants {
        static let name = "Name:"
        static let amount = "Amount:"
        static let currency = "Currency:"
        static let namePlaceHolder = "type name"
        static let amountPlaceHolder = "type amount"
    }

    //MARK: - IBOutlets

    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var currencyButton: UIButton!


    //MARK: - Private properties

    private var newName: String?
    private var newAmount: Double?
    private var newCurrency: Currency?
    private var currentIndex: Int?
    private var output: EditBudgetViewController?


    //MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        configureButton()
        configureFields()
    }


    //MARK: - Public methods

    func configure(with text: String?, and index: Int, parentModule: EditBudgetViewController) {
        output = parentModule
        currentIndex = index
        guard let text = text else {
            return
        }
        valueTextField.text = text
        currencyButton.setTitle(text, for: .normal)
        if index == 2 {
            valueTextField.isHidden = true
            currencyButton.isHidden = false
        }
        configureLabels(from: index)
    }

    //MARK: - Private methods

    private func configureButton() {
        currencyButton.isHidden = true
        currencyButton.titleLabel?.textAlignment = .left
        currencyButton.addTarget(self, action: #selector(appearedPicker), for: .touchUpInside)
    }

    @objc private func appearedPicker() {
        output?.appearPicker()
    }

    private func configureFields() {
        valueTextField.textAlignment = .right
        valueTextField.borderStyle = .none
        valueTextField.clearButtonMode = .whileEditing
        valueTextField.delegate = self
    }

    private func configureLabels(from index: Int) {
        var text = ""
        switch index {
        case 0:
            text = Constants.name
            valueTextField.placeholder = Constants.namePlaceHolder
        case 1:
            text = Constants.amount
            valueTextField.placeholder = Constants.amountPlaceHolder
            valueTextField.keyboardType = .numberPad
        case 2:
            text = Constants.currency
        default:
            text = "UnknowField"
        }
        keyLabel.text = text
    }

}


//MARK: - Extensions

extension EditBudgetTableViewCell: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        valueTextField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        configureNewValueForBudget()
    }

    private func configureNewValueForBudget() {
        guard let index = currentIndex,
            let text = valueTextField.text else {
            return
        }
        switch index {
        case 0:
            newName = text
        case 1:
            newAmount = Double(text)
        case 2:
            newCurrency = Currency.ruble
        default:
            return
        }
    }

}
