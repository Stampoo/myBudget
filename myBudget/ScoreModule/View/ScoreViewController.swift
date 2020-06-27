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
        configureScoreCollection()
        configurateNavbar()
        configureAddButton()
    }
    
    
    //MARK: - Private methods
    
    private func configureScoreCollection() {
        let nib = UINib(nibName: Constants.nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.cellIdentifire)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }

    private func configurateNavbar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Constants.budgetTitle
    }

    private func configureAddButton() {
        let button = UIButton(type: .contactAdd)
        button.setTitleColor(.black, for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        button.addTarget(self, action: #selector(addNewBudget), for: .touchUpInside)
    }

    @objc private func addNewBudget() {
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
        return cell
    }

}

extension ScoreViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height / 8
    }
}

extension ScoreViewController: ScoreViewInput {
    
    func configure() {}
    
    func setupInitialState() {
        budgetList = TempBudgetStorageService.shared.openBudgetList()
        tableView.reloadData()
    }
    
}


