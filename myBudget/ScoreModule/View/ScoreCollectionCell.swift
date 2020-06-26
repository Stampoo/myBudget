//
//  ScoreCollectionCell.swift
//  myBudget
//
//  Created by fivecoil on 26/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class ScoreCollectionCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var backgroundCardView: UIView!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var currencyLabel: UILabel!
    @IBOutlet private weak var amountTextField: UITextField!
    
    
    //MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configureCard()
    }
    
    
    //MARK: - Public methods
    
    func configureCell() {}
    
    
    //MARK: - Private methods
    
    private func configureCard() {
        contentView.layer.cornerRadius = contentView.frame.height / 8
        contentView.addLightShadow()
        backgroundCardView.backgroundColor = .black
    }
    
}
