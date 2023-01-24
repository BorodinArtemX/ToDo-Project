//
//  SomeCollectionView.swift
//  MyToDoProject
//
//  Created by Артем Бородин on 22/01/2023.
//

import UIKit
import SnapKit

final class SomeCollectionView: UITableViewCell {
    
    private let taskLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with task: String) {
        taskLabel.text = task
    }
    
    private func setupLayout() {
        addSubview(taskLabel)

        taskLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(10)
        }
    }
}
