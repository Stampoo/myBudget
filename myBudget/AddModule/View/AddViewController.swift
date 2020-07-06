//
//  AddViewController.swift
//  myBudget
//
//  Created by fivecoil on 26/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class AddViewController: UIViewController, ModuleTransitionable {

    //MARK: - Constants

    private enum Constants {
        static let pickerAnimationDuration = 0.5
        static let namePlaceHolder = "Type name of ur budget"
        static let amountPlaceHolder = "Type amount"
        static let createButtonTitle = "Create"
        static let fieldColor = UIColor.init(red: 240/255, green: 237/255, blue: 238/255, alpha: 1)
    }

    //MARK: - IBOutlets

    @IBOutlet private weak var nameBudget: UITextField!
    @IBOutlet private weak var amountMonth: UITextField!
    @IBOutlet private weak var currencyButton: UIButton!
    @IBOutlet private weak var createButton: UIButton!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!


    //MARK: - Public properties

    var output: AddViewOutput?


    //MARK: - Private properties

    private var currencyList: [Currency] = [.bRuble, .euro, .ruble, .USD]
    private var currencyDate = Date()
    private let picker = UIPickerView()
    private let datePicker = UIDatePicker()
    private var pickerIsHidden = true
    private var currentCurency: Currency?
    private var isTransactionMode = false
    private var pickerHeightAnchor = NSLayoutConstraint()


    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureFields()
        configureLabels()
        configureDatePicker()
        configureCurrencyPicker()
        output?.reload()
        configureCurrencyButton()
        configureCreateButton()
    }


    //MARK: - Private methods

    private func configureLabels() {
        titleLabel.font = .boldSystemFont(ofSize: 25)
        titleLabel.textAlignment = .center
    }

    private func configureFields() {
        let fields = [nameBudget, amountMonth]
        let leftView = UIView(frame: .init(x: 0, y: 0, width: 5, height: 20))
        fields.forEach {
            $0?.borderStyle = .none
            $0?.backgroundColor = Constants.fieldColor
            $0?.layer.cornerRadius = ($0?.frame.height ?? 0) / 4
            $0?.clipsToBounds = true
            $0?.textColor = .black
            $0?.leftView = leftView
        }
        nameBudget.placeholder = Constants.namePlaceHolder
        amountMonth.placeholder = Constants.amountPlaceHolder
        amountMonth.keyboardType = .numberPad
    }

    private func configureCurrencyPicker() {
        picker.layer.cornerRadius = view.frame.height * 0.3 / 8
        picker.backgroundColor = UIColor.shared.getCustom(color: .lightGray)
        picker.dataSource = self
        picker.delegate = self
        picker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picker)
    }

    private func configureCurrencyButton() {
        currencyButton.addTarget(self, action: #selector(appearPicker), for: .touchUpInside)
        currencyButton.backgroundColor = UIColor().getCustom(color: .indigo)
        currencyButton.layer.cornerRadius = currencyButton.frame.height / 4
        currencyButton.setTitleColor(.white, for: .normal)
    }

    @objc private func appearPicker() {
        let pickerView = isTransactionMode ? datePicker : picker
        switch pickerIsHidden {
        case true:
            animatePicker(isHidden: true, duration: Constants.pickerAnimationDuration, picker: pickerView)
            pickerIsHidden = !pickerIsHidden
        case false:
            animatePicker(isHidden: false, duration: Constants.pickerAnimationDuration, picker: pickerView)
            pickerIsHidden = !pickerIsHidden
        }
        view.endEditing(true)
    }

    private func animatePicker(isHidden: Bool, duration: Double, picker: UIView) {
        UIView.animate(withDuration: 0.3) {
            if !isHidden {
                self.pickerHeightAnchor.constant = 0
                self.view.layoutIfNeeded()
            } else {
                self.pickerHeightAnchor.constant = self.view.frame.height * 0.3
                self.view.layoutIfNeeded()
            }
        }
    }

    private func configureCreateButton() {
        createButton.backgroundColor = UIColor().getCustom(color: .blue)
        createButton.setTitleColor(.white, for: .normal)
        createButton.setTitle(Constants.createButtonTitle, for: .normal)
        createButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
        createButton.layer.cornerRadius = createButton.frame.height / 4
        createButton.addTarget(self, action: #selector(dismissAndCreate), for: .touchUpInside)
    }

    @objc private func dismissAndCreate() {
        switch isTransactionMode {
        case true:
            createTransaction()
        case false:
            createBudget()
        }
    }

    private func createTransaction() {
        guard let name = nameBudget.text,
            let amount = amountMonth.text,
            let amountDouble = Double(amount) else {
                return
        }
        let transaction = Transaction(name: name, amount: -amountDouble, date: currencyDate)
        output?.dismiss(with: transaction)
    }

    private func createBudget() {
        guard let name = nameBudget.text,
            let amount = amountMonth.text,
            let amountDouble = Double(amount),
            let currency = currentCurency else {
                return
        }
        let budget = Budget(name: name, amount: amountDouble, currency: currency)
        output?.dismiss(with: budget)

    }

    private func configureDatePicker() {
        datePicker.layer.cornerRadius = view.frame.height * 0.3 / 8
        datePicker.backgroundColor = UIColor.shared.getCustom(color: .lightGray)
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(datePicker)
    }

    @objc private func dateChanged(target: UIDatePicker) {
        let fromat = "EEEE, MMM d, yyyy"
        let formattingDate = target.date.getFormattedDate(format: fromat)
        currencyDate = target.date
        dateLabel.text = formattingDate
    }

}


//MARK: - Extensions

extension AddViewController: AddViewInput {

    func configureCurrency() {
        currencyButton.setTitle("Currency", for: .normal)
        titleLabel.text = "Create new budget"
        datePicker.isHidden = true
        dateLabel.isHidden = true
        pickerConstraint()
    }

    func configureDate() {
        dateLabel.text = ""
        titleLabel.text = "Create new transaction"
        currencyButton.setTitle("Date", for: .normal)
        picker.isHidden = true
        isTransactionMode = true
        dateLabel.isHidden = false
        pickerConstraint()
    }

    func setupInitialState() {}

}

extension AddViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        currencyList.count
    }

}

extension AddViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        currencyList[row].rawValue
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currencyButton.setTitle(currencyList[row].rawValue, for: .normal)
        currentCurency = currencyList[row]
        animatePicker(isHidden: false, duration: Constants.pickerAnimationDuration, picker: picker)
        pickerIsHidden = !pickerIsHidden
    }

}

extension AddViewController {

    private func pickerConstraint() {
        let picker = isTransactionMode ? datePicker : self.picker
        pickerHeightAnchor = picker.heightAnchor.constraint(equalToConstant: 0)
        NSLayoutConstraint.activate([
            picker.leftAnchor.constraint(equalTo: view.leftAnchor),
            picker.rightAnchor.constraint(equalTo: view.rightAnchor),
            picker.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pickerHeightAnchor
        ])
    }

}
