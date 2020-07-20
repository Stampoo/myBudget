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
    
    private let budgetsTable = UITableView()
    private var budgetList = [Budget]()
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
        configureBudgetsTable()
        configurateNavbar()
        configureAddBudgetButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output?.reload()
        budgetsTable.reloadData()
    }
    
    
    //MARK: - Private methods
    
    private func configureBudgetsTable() {
        let nib = UINib(nibName: Constants.nibName, bundle: nil)
        budgetsTable.register(nib, forCellReuseIdentifier: Constants.cellIdentifire)
        view.addSubview(budgetsTable)
        budgetsTable.setConstraints(to: view)
        budgetsTable.dataSource = self
        budgetsTable.delegate = self
        budgetsTable.separatorStyle = .none
    }

    private func configurateNavbar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Constants.budgetTitle
    }

    private func configureAddBudgetButton() {
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
        budgetsTable.reloadData()
    }
    
    func setupInitialState() {
        budgetList = TempBudgetStorageService.shared.openBudgetList()
        budgetsTable.reloadData()
    }
    
}
