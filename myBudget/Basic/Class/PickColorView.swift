//
//  ColorizeView.swift
//  myBudget
//
//  Created by fivecoil on 03/07/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

protocol PickColorViewDelegate {

    func didColorSelect(selected colors: UIColor)

}

final class PickColorView: UIView {

    //MARK: - Constants

    private enum Constants {
        static let defaultColors: [UIColor] = [.magenta, .yellow, .brown, .orange]
    }

    //MARK: - Public properties

    var delegate: PickColorViewDelegate?


    //MARK: Private properties

    private var colorButtons = [UIButton]()
    private let cardView = UIView()

    //MARK: - initizlizers

    convenience init() {
        self.init(frame: .zero)
        update()
    }


    override func draw(_ rect: CGRect) {
        super.draw(rect)
        update()
    }


    //MARK: Public methods



    //MARK: - Private methods

    private func createButtons() {
        colorButtons = []
        for color in Constants.defaultColors {
            let colorButton = UIButton()
            colorButton.backgroundColor = color
            colorButton.layer.cornerRadius = colorButton.frame.height / 2
            colorButton.clipsToBounds = true
            colorButton.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
            colorButtons.append(colorButton)
        }
    }

    @objc private func tapAction(target: UIButton) {
        guard let color = target.backgroundColor else {
            return
        }
        delegate?.didColorSelect(selected: color)
        hideSelf()
    }

    private func hideSelf() {
        isHidden = true
    }

    private func createStackView() {
        let stackView = UIStackView(arrangedSubviews: colorButtons)
        stackView.axis = .horizontal
        stackView.contentMode = .scaleToFill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }

    private func update() {
        setFrame()
        createButtons()
        createStackView()
    }

    private func setFrame() {
        self.bounds = CGRect(x: 0, y: 0, width: 150, height: 30)
    }

}
