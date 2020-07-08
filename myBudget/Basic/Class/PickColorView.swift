//
//  ColorizeView.swift
//  myBudget
//
//  Created by fivecoil on 03/07/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

protocol PickColorViewDelegate {

    func didSelectColor(selected color: UIColor)

}

final class PickColorView: UIView {

    //MARK: - Constants

    private enum Constants {
        static let defaultColors: [UIColor] = [.magenta, .yellow, .brown, .orange]
        static let colorCornerRadius: CGFloat = 7.5
    }


    //MARK: - Public properties

    var delegate: PickColorViewDelegate?


    //MARK: Private properties

    private var colorButtons = [UIButton]()
    private let cardView = UIView()


    //MARK: - initizlizers

    override init(frame: CGRect) {
        super.init(frame: frame)
        update()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //MARK: - Lifecycle

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        update()
    }


    //MARK: - Private methods

    private func createButtons() {
        colorButtons = []
        for color in Constants.defaultColors {
            let colorButton = UIButton()
            colorButton.backgroundColor = color
            colorButton.layer.cornerRadius = Constants.colorCornerRadius
            colorButton.clipsToBounds = true
            colorButton.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
            colorButtons.append(colorButton)
        }
    }

    @objc private func tapAction(target: UIButton) {
        guard let color = target.backgroundColor else {
            return
        }
        delegate?.didSelectColor(selected: color)
        hideSelf()
    }

    private func hideSelf() {
        isHidden = true
    }

    private func createStackView() {
        let stackView = UIStackView(arrangedSubviews: colorButtons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 2
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.setConstraints(to: self)
    }

    private func update() {
        createButtons()
        createStackView()
    }

}
