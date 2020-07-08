//
//  CreateViewController.swift
//  myBudget
//
//  Created by fivecoil on 26/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class ScoreViewController: UIViewController, ModuleTransitionable {
    
    //MARK: - Constants
    
    private enum Constants {
        static let cellIdentifire = "ScoreCell"
        static let nibName = "ScoreTableViewCell"
        static let budgetTitle = "My budget"
    }
    
    //MARK: - Public properties
    
    var output: ScoreViewOutput?
    
    
    //MARK: - Private properties
    
    private let tableView = UITableView()
    private var budgetList = [Budget]()
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingActualRateForCurrency()
        output?.viewLoaded()
        configureTableView()
        configurateNavbar()
        configureAddButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output?.reload()
        tableView.reloadData()
    }
    
    
    //MARK: - Private methods
    
    private func configureTableView() {
        let nib = UINib(nibName: Constants.nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.cellIdentifire)
        view.addSubview(tableView)
        tableView.setConstraints(to: view)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }

    private func configurateNavbar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Constants.budgetTitle
    }

    private func configureAddButton() {
        navigationItem.backBarButtonItem?.tintColor = .white
        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(showAddModule))
        let backBarButtton = UIBarButtonItem(title: "",
                                             style: .plain,
                                             target: self,
                                             action: #selector(popToPreviousModule))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.backBarButtonItem = backBarButtton
    }

    @objc private func popToPreviousModule() {
        popModule(animated: true)
    }

    @objc private func showAddModule() {
        output?.presentModule()
    }

    private func loadingActualRateForCurrency() {
        let converter = CurrencyConverter()
        converter.updateRates()
    }
    
}


//MARK: - Extensions

extension ScoreViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return budgetList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifire,
                                                       for: indexPath) as? ScoreTableViewCell else {
                                                        return UITableViewCell()
        }
        cell.configureCell(with: budgetList[indexPath.row])
        return cell
    }

}

extension ScoreViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            budgetList.remove(at: indexPath.row)
            TempBudgetStorageService.shared.saveBudgetList(budgetList: budgetList)
            tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let budget = budgetList[indexPath.row]
        output?.pushTransactionModule(with: budget)
    }

}

extension ScoreViewController: ScoreViewInput {
    
    func configure(with budgetList: [Budget]) {
        self.budgetList = budgetList
        tableView.reloadData()
    }
    
    func setupInitialState() {
        budgetList = TempBudgetStorageService.shared.openBudgetList()
        tableView.reloadData()
    }
    
}
