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
    }

    //MARK: - IBOutlets

    @IBOutlet private weak var nameBudget: UITextField!
    @IBOutlet private weak var amountMonth: UITextField!
    @IBOutlet private weak var currencyButton: UIButton!
    @IBOutlet private weak var createButton: UIButton!
    @IBOutlet private weak var dateLabel: UILabel!


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


    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        dateLabel.isHidden = true
        dateLabel.text = ""
        output?.reload()
        configureFields()
        configureCurrencyPicker()
        configureCurrencyButton()
        configureCreateButton()
    }


    //MARK: - Private methods

    private func configureFields() {
        nameBudget.borderStyle = .none
        nameBudget.placeholder = Constants.namePlaceHolder
        amountMonth.borderStyle = .none
        amountMonth.placeholder = Constants.amountPlaceHolder
    }

    private func configureCurrencyPicker() {
        let pickerFrame = CGRect(x: 0,
                                 y: view.bounds.height,
                                 width: view.bounds.width,
                                 height: view.bounds.height * 0.3)
        picker.frame = pickerFrame
        picker.dataSource = self
        picker.delegate = self
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
    }

    private func animatePicker(isHidden: Bool, duration: Double, picker: UIView) {
        let viewHeight = view.bounds.height
        let animation = UIViewPropertyAnimator(duration: duration, curve: .linear, animations: {})
        animation.addAnimations {
            if isHidden {
                picker.transform = CGAffineTransform(translationX: 0, y: viewHeight * -0.4)
            } else {
                picker.transform = CGAffineTransform(translationX: 0, y: viewHeight * 0.4)
            }
        }
        animation.startAnimation()
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
        let transaction = Transaction(name: name, amount: amountDouble, date: currencyDate)
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

    private func createDatePicker() {
        let pickerFrame = CGRect(x: 0,
                                 y: view.bounds.height,
                                 width: view.bounds.width,
                                 height: view.bounds.height * 0.4)
        datePicker.frame = pickerFrame
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
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
        print("currency")
    }

    func configureDate() {
        currencyButton.setTitle("Date", for: .normal)
        print("date")
        isTransactionMode = true
        createDatePicker()
        dateLabel.isHidden = false
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
