//
//  EditBudgetViewController.swift
//  myBudget
//
//  Created by fivecoil on 06/07/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class EditBudgetViewController: UIViewController, ModuleTransitionable {

    //MARK: - Constants

    private enum Constants {
        static let identifire = "editBudgetCell"
        static let nibName = "EditBudgetTableViewCell"
        static let cellCount = 3
        static let cellInSection = 1
        static let titleText = "Configure current budget"
        static let saveButtonTitle = "Save changes"
    }

    //MARK: - IBOutlets

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButton: UIButton!


    //MARK: - Public properties

    var output: EditBudgetViewOutput?
    lazy var transferNewName: ((String?) -> Void) = { (newName) in
        self.newName = newName
    }
    lazy var transferNewAmount: ((Double?) -> Void) = { (newAmount) in
        self.newAmount = newAmount
    }
    lazy var appearPicker = {
        self.appearedPicker()
    }


    //MARK: - Private properties

    private var isTest = false
    private let sectionHeaders = [
        "Name",
        "Amount",
        "Currency"
    ]
    private var budget: Budget?
    private let currencyPicker = UIPickerView()
    private var currencyPickerHeightAnchor = NSLayoutConstraint()
    private var currencyList: [Currency] = [.bRuble, .euro, .ruble, .USD]
    private var newName: String?
    private var newAmount: Double?
    private lazy var pickedCurrency = budget?.currency
    private var isAppeared = false
    private var budgetStorage = TempBudgetStorageService.shared
    private var transactionStorage = TempHistoryStorageService.shared


    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
        configurePicker()
        configureTitle()
        configureTable()
        configureButton()
    }


    //MARK: - Private methods

    private func configurePicker() {
        currencyPicker.translatesAutoresizingMaskIntoConstraints = false
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.backgroundColor = UIColor.shared.getCustom(color: .lightGray)
        currencyPicker.layer.cornerRadius = view.frame.height * 0.3 / 8
        view.addSubview(currencyPicker)
        currencyPickerConstraint()
    }

    private func configureTitle() {
        if let budget = budget {
            navigationItem.title = "Configure \(budget.name)"
        } else {
            navigationItem.title = Constants.titleText
        }

    }

    private func configureTable() {
        let nib = UINib(nibName: Constants.nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.identifire)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }

    private func configureButton() {
        saveButton.backgroundColor = UIColor.shared.getCustom(color: .blue)
        saveButton.setTitle(Constants.saveButtonTitle, for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = saveButton.frame.height /  4
        saveButton.addTarget(self, action: #selector(saveChanges), for: .touchUpInside)
    }

    @objc private func appearedPicker() {
        view.resignFirstResponder()
        UIView.animate(withDuration: 0.3) {
            if self.isAppeared {
                self.currencyPickerHeightAnchor.constant = 0
                self.isAppeared = !self.isAppeared
                self.view.layoutIfNeeded()
            } else {
                self.currencyPickerHeightAnchor.constant = self.view.frame.height * 0.3
                self.view.layoutIfNeeded()
                self.isAppeared = !self.isAppeared
            }
        }
    }

    @objc private func saveChanges() {
        guard let budget = budget else {
            return
        }
        let newName = self.newName ?? budget.name
        let newAmount = self.newAmount ?? budget.amount
        let newCurrency = self.pickedCurrency ?? budget.currency
        let newBudget = Budget(name: newName, amount: newAmount, currency: newCurrency)
        budgetStorage.addBudgetInList(budget: newBudget)
        _ = budgetStorage.delete(budget: budget)
        if budget.name != newBudget.name {
            transactionStorage.migrateHistoryAfterRename(from: budget, toBudget: newBudget)
        }
        output?.reload(with: newBudget)
    }

}


//MARK: - Extensions

extension EditBudgetViewController: EditBudgetViewInput {

    func configure(with budget: Budget) {
        self.budget = budget
        tableView.reloadData()
    }

    func setupInitialState() {}

}

extension EditBudgetViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        Constants.cellCount
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Constants.cellInSection
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.identifire,
                                                       for: indexPath) as? EditBudgetTableViewCell else {
                                                        return UITableViewCell()
        }
        let budgetElements = [budget?.name, budget?.amount.formatNumber(), pickedCurrency?.rawValue]
        cell.configure(with: budgetElements[indexPath.section], and: indexPath.section, parentModule: self)
        return cell
    }

}

extension EditBudgetViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionHeaders[section]
    }

}

extension EditBudgetViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        currencyList.count
    }

}

extension EditBudgetViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        currencyList[row].rawValue
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedCurrency = currencyList[row]
        tableView.reloadRows(at: [[2, 0]], with: .automatic)
        appearPicker()
    }

}

extension EditBudgetViewController {

    private func currencyPickerConstraint() {
        currencyPickerHeightAnchor = currencyPicker.heightAnchor.constraint(equalToConstant: 0)
        NSLayoutConstraint.activate([
            currencyPicker.leftAnchor.constraint(equalTo: view.leftAnchor),
            currencyPicker.rightAnchor.constraint(equalTo: view.rightAnchor),
            currencyPicker.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            currencyPickerHeightAnchor
        ])
    }

}

