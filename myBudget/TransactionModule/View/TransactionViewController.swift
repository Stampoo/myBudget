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
    }


    //MARK: - IBOutlets

    @IBOutlet private weak var nameBudgetLabel: UILabel!
    @IBOutlet private weak var backgroundTopView: UIView!
    @IBOutlet private weak var transferButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var budgetAmountLabel: UILabel!
    @IBOutlet private weak var budgetSpentLabel: UILabel!
    @IBOutlet private weak var sortButton: UIButton!


    //MARK: - Public properties

    var output: TransactionViewOutput?


    //MARK: - Private properties

    private var transactionHistory = [Transaction]()


    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
        configureFilterButton()
        configreTransferButton()
        configureTable()
        configureLables()
        addButton()
    }


    //MARK: - Privat methods

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
        let leftBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTransaction))
        leftBarButton.tintColor = .white
        navigationItem.rightBarButtonItem = leftBarButton
    }

    @objc private func addTransaction() {
        output?.present()
    }

    private func configreTransferButton() {
        transferButton.setTitle("Transfer to", for: .normal)
        transferButton.backgroundColor = UIColor().getCustom(color: .blue)
        transferButton.setTitleColor(.white, for: .normal)
        transferButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
        transferButton.layer.cornerRadius = transferButton.frame.height / 4
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
        let historyStorage = TempHistoryStorageService.shared
        nameBudgetLabel.text = budget.name
        budgetAmountLabel.text = "Budget: \(budget.amount)"
        budgetSpentLabel.text = "Left: \(budget.amount - historyStorage.calculateSpent(budget: budget))"
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
