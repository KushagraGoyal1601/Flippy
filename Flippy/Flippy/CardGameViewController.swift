//
//  ViewController.swift
//  Flippy
//
//  Created by Kushagra Goyal on 11/03/25.
//

import UIKit

class CardGameViewController: UIViewController {

    private var cardCollectionView: UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.main.bounds.width - 20
        layout.itemSize = CGSize(width: screenWidth / 4 - 10, height: 100)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell().identifier)
        return view
    }()
    
    var viewModel = CardGameViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cardCollectionView)
        
        cardCollectionView.delegate = self
        cardCollectionView.dataSource = self
        
        addConstraints()
    }
    
    private func addConstraints() {
        let cardCollectionViewConstraints = [
            cardCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cardCollectionView.widthAnchor.constraint(equalToConstant: view.bounds.width),
            cardCollectionView.heightAnchor.constraint(equalToConstant: 450)
        ]
        
        NSLayoutConstraint.activate(cardCollectionViewConstraints)
    }
}

extension CardGameViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell().identifier, for: indexPath) as? CardCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .blue
        cell.cardlabel.text = viewModel.cardArray[indexPath.row].value
        cell.cardlabel.isHidden = !viewModel.cardArray[indexPath.row].isFLipped
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.cardDidTapped(at: indexPath.row)
        collectionView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.viewModel.checkIfMatchFound(at: indexPath.row)
            collectionView.reloadData()
        }
    }


}

