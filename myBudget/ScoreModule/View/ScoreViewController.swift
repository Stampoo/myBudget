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
    }
    
    //MARK: - Public properties
    
    var output: ScoreViewOutput?
    
    
    //MARK: - Private properties
    
    @IBOutlet private weak var scoreCollectionVIew: UICollectionView!
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScoreCollection()
    }
    
    
    //MARK: - Private methods
    
    private func configureScoreCollection() {}
    
}


//MARK: - Extensions

extension ScoreViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
    
}

extension ScoreViewController: UICollectionViewDelegate {}

extension ScoreViewController: ScoreViewInput {
    
    func configure() {}
    
    func setupInitialState() {}
    
}


