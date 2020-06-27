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
        static let createButtonTitle = "Create budget"
    }

    //MARK: - IBOutlets

    @IBOutlet private weak var nameBudget: UITextField!
    @IBOutlet private weak var amountMonth: UITextField!
    @IBOutlet private weak var currencyButton: UIButton!
    @IBOutlet private weak var createButton: UIButton!


    //MARK: - Public properties

    var output: AddViewOutput?


    //MARK: - Private properties

    private var currencyList: [Currency] = [.bRuble, .euro, .ruble, .USD]
    private let picker = UIPickerView()
    private var pickerIsHidden = true
    private var currentCurency: Currency?


    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCurrencyPicker()
        configureCurrencyButton()
        configureCreateButton()
        modalPresentationStyle = .fullScreen
    }


    //MARK: - Private methods

    private func configureLables() {
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
        currencyButton.backgroundColor = .cyan
        currencyButton.layer.cornerRadius = currencyButton.frame.height / 2
        currencyButton.setTitleColor(.white, for: .normal)
    }

    @objc private func appearPicker() {
        switch pickerIsHidden {
        case true:
            animatePicker(isHidden: true, duration: Constants.pickerAnimationDuration)
            pickerIsHidden = !pickerIsHidden
        case false:
            animatePicker(isHidden: false, duration: Constants.pickerAnimationDuration)
            pickerIsHidden = !pickerIsHidden
        }
    }

    private func animatePicker(isHidden: Bool, duration: Double) {
        let viewHeight = view.bounds.height
        let animation = UIViewPropertyAnimator(duration: duration, curve: .linear, animations: {})
        animation.addAnimations {
            if isHidden {
                self.picker.transform = CGAffineTransform(translationX: 0, y: viewHeight * -0.4)
            } else {
                self.picker.transform = CGAffineTransform(translationX: 0, y: viewHeight * 0.4)
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
        createButton.addTarget(self, action: #selector(dismissAndCreateBudget), for: .touchUpInside)
    }

    @objc private func dismissAndCreateBudget() {
        guard let name = nameBudget.text,
            let amount = amountMonth.text,
            let amountDouble = Double(amount),
            let currency = currentCurency else {
                return
        }
        let budget = Budget(name: name, amount: amountDouble, currency: currency)
        output?.pop(with: budget)
    }

}


//MARK: - Extensions

extension AddViewController: AddViewInput {

    func configure() {}

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
        animatePicker(isHidden: false, duration: Constants.pickerAnimationDuration)
        pickerIsHidden = !pickerIsHidden
    }

}
