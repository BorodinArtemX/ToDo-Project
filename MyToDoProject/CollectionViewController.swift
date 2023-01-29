//
//  CollectionViewController.swift
//  MyToDoProject
//
//  Created by Артем Бородин on 24/01/2023.
//

import UIKit
import SnapKit

    final class SomeCollectionViewCell: UICollectionViewCell {
        
        let someLabel: UILabel = {
            let label = UILabel()
            label.text = "   Some text"
            return label
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .blue
            setupLayout()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupLayout() {
            addSubview(someLabel)
            
            someLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                someLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                someLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                someLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        }
    }


