//
//  TransactionViewController.swift
//  myBudget
//
//  Created by fivecoil on 28/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class TransactionViewController: UIViewController, ModuleTransitionable {

    //MARK: - Constants

    private enum Constants {
        static let cellIdentifire = "TransactionCell"
        static let cellNib = "TransactionTableViewCell"
        static let transferAmountPlaceHolder = "Type amount"
    }


    //MARK: - IBOutlets

    @IBOutlet private weak var nameBudgetLabel: UILabel!
    @IBOutlet private weak var backgroundTopView: UIView!
    @IBOutlet private weak var transferButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var budgetAmountLabel: UILabel!
    @IBOutlet private weak var budgetSpentLabel: UILabel!
    @IBOutlet private weak var sortButton: UIButton!

    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var toButton: UIButton!
    @IBOutlet private weak var amountTextField: UITextField!
    @IBOutlet private weak var sendButton: UIButton!


    //MARK: - Public properties

    var output: TransactionViewOutput?


    //MARK: - Private properties

    private var transactionHistory = [Transaction]()
    private var isTransferMode = false
    private let budgetPicker = UIPickerView()
    private var budgetList = [Budget]()
    private var isChoiseREcipient = false
    private var toBudget: Budget?
    private var fromBudget: Budget?
    private var isDecrease = true
    private var toPickerHeightAnchor = NSLayoutConstraint()
    private var isAppeared = false


    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTransferViews()
        createPicker()
        transferMode(isTransfer: isTransferMode)
        output?.viewLoaded()
        configureFilterButton()
        configreTransferButton()
        configureTable()
        configureLables()
        addButton()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }


    //MARK: - Privat methods

    private func configureTransferViews() {
        let buttons = [
            cancelButton,
            toButton,
            amountTextField,
            sendButton
        ]
        amountTextField.placeholder = Constants.transferAmountPlaceHolder
        buttons.forEach { $0?.layer.cornerRadius = ($0?.frame.height ?? 0) / 4 }
        cancelButton.addTarget(self, action: #selector(enableTransfer), for: .touchUpInside)
        toButton.addTarget(self, action: #selector(choiseRecipient), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(createTransfer), for: .touchUpInside)
        sortButton.addTarget(self, action: #selector(sortTransaction), for: .touchUpInside)
        amountTextField.keyboardType = .numberPad
    }

    @objc private func sortTransaction() {
        guard let budget = fromBudget else {
            return
        }
        let sortService = TransactionFilter()
        let sortedTransaction = sortService.filterBy(type: .date, to: budget)
        transactionHistory = isDecrease ? sortedTransaction : sortedTransaction.reversed()
        tableView.reloadData()
        isDecrease = !isDecrease
    }

    @objc private func createTransfer() {
        guard let toBudget = toBudget,
            let amount = amountTextField.text,
            let amountDouble = Double(amount),
            let fromBudget = fromBudget else {
                return
        }
        let transferService = Transfer()
        transferService.trasferMoney(from: fromBudget, to: toBudget, amount: amountDouble)
        enableTransfer()
        output?.reload()
    }

    private func createPicker() {
        budgetPicker.backgroundColor = UIColor.shared.getCustom(color: .lightGray)
        budgetPicker.dataSource = self
        budgetPicker.delegate = self
        budgetPicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(budgetPicker)
        toPickerConstraint()
    }

    private func configureTable() {
        let nib = UINib(nibName: Constants.cellNib, bundle: nil)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(nib, forCellReuseIdentifier: Constants.cellIdentifire)
    }

    private func configureLables() {
        nameBudgetLabel.textColor = .white
        nameBudgetLabel.textAlignment = .center
        nameBudgetLabel.font = .boldSystemFont(ofSize: 35)
        budgetAmountLabel.textColor = .white
        budgetAmountLabel.textAlignment = .center
        budgetAmountLabel.font = .boldSystemFont(ofSize: 25)
        budgetSpentLabel.textColor = .white
        budgetSpentLabel.textAlignment = .center
        budgetSpentLabel.font = .boldSystemFont(ofSize: 20)
    }

    private func addButton() {
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTransaction))
        let secondRightBarButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editBudget))
        rightBarButton.tintColor = .white
        secondRightBarButton.tintColor = .white
        navigationItem.rightBarButtonItems = [rightBarButton, secondRightBarButton]
    }

    @objc private func addTransaction() {
        output?.present()
    }

    @objc private func editBudget() {
        output?.push()
    }

    private func configreTransferButton() {
        transferButton.setTitle("Transfer to", for: .normal)
        transferButton.backgroundColor = UIColor().getCustom(color: .blue)
        transferButton.setTitleColor(.white, for: .normal)
        transferButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
        transferButton.layer.cornerRadius = transferButton.frame.height / 8
        transferButton.addTarget(self, action: #selector(enableTransfer), for: .touchUpInside)
    }

    @objc private func enableTransfer() {
        isTransferMode = !isTransferMode
        transferMode(isTransfer: isTransferMode)
        transferButton.isHidden = isTransferMode
    }


    private func configureFilterButton() {
        sortButton.tintColor = .white
        sortButton.backgroundColor = UIColor().getCustom(color: .blue)
        sortButton.addLightShadow()
        sortButton.layer.cornerRadius = sortButton.frame.height / 2
    }
    
}


//MARK: - Extensions

extension TransactionViewController: TransactionViewInput {
    
    func configure(with budget: Budget) {
        budgetList = TempBudgetStorageService.shared.budgetListWithout(budget: budget)
        let symbol = budget.currency.rawValue.getCurrencyLiteral()
        fromBudget = budget
        let historyStorage = TempHistoryStorageService.shared
        transactionHistory = historyStorage.openHistory(budget: budget)
        nameBudgetLabel.text = budget.name
        budgetAmountLabel.text = "Budget: " + DoubleFormatter.shared.convertToString(from: budget.amount) + symbol
        let left = budget.amount - historyStorage.calculateSpent(budget: budget)
        budgetSpentLabel.text = "Left: " + DoubleFormatter.shared.convertToString(from: left) + symbol
        tableView.reloadData()
    }

    func configure(with transaction: Transaction) {}

    func setupInitialState(with transactionHistory: [Transaction]) {
        self.transactionHistory = transactionHistory
        tableView.reloadData()
    }

}

extension TransactionViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        transactionHistory.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifire,
                                                       for: indexPath) as? TransactionTableViewCell else {
                                                        return UITableViewCell()
        }
        cell.configureCell(with: transactionHistory[indexPath.row])
        return cell
    }

}

extension TransactionViewController: UITableViewDelegate {}

extension TransactionViewController {

    private func transferMode(isTransfer: Bool) {
        let transferView =  [
            cancelButton,
            toButton,
            amountTextField,
            sendButton
        ]
        transferView.forEach { $0?.isHidden = !isTransfer }
    }

    @objc private func choiseRecipient() {
        appearPicker(picker: budgetPicker)
        view.endEditing(true)
    }

    private func appearPicker(picker: UIView) {
        UIView.animate(withDuration: 0.3) {
            if self.isAppeared {
                self.toPickerHeightAnchor.constant = 0
                self.isAppeared = !self.isAppeared
                self.view.layoutIfNeeded()
            } else {
                self.toPickerHeightAnchor.constant = self.view.frame.height * 0.3
                self.view.layoutIfNeeded()
                self.isAppeared = !self.isAppeared
            }
        }
    }

}

extension TransactionViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        budgetList.count
    }

}

extension TransactionViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        budgetList[row].name
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let choosenBudget = budgetList[row]
        toBudget = choosenBudget
        toButton.setTitle(choosenBudget.name, for: .normal)
        appearPicker(picker: budgetPicker)
    }

}

extension TransactionViewController {

    private func toPickerConstraint() {
        toPickerHeightAnchor = budgetPicker.heightAnchor.constraint(equalToConstant: 0)
        NSLayoutConstraint.activate([
            budgetPicker.leftAnchor.constraint(equalTo: view.leftAnchor),
            budgetPicker.rightAnchor.constraint(equalTo: view.rightAnchor),
            budgetPicker.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            toPickerHeightAnchor
        ])
    }

}
