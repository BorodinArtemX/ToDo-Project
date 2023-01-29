//
//  ViewController.swift
//  MyToDoProject
//
//  Created by Артем Бородин on 21/01/2023.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {
    
 lazy var someCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 1
    //layout.minimumInteritemSpacing = 15
     layout.itemSize = CGSize(width: view.bounds.maxX , height: 50)
    
     let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.register(SomeCollectionViewCell.self, forCellWithReuseIdentifier: "SomeCollectionViewCell")
    collectionView.showsVerticalScrollIndicator = false
    collectionView.delegate = self
    collectionView.dataSource = self
    return collectionView
}()

override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupLayout()
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTask))
}
    @objc private func addNewTask() {
        print("New task")
        let alert = UIAlertController(title: "New task", message: nil, preferredStyle: .alert)
        alert.addTextField()
        let okAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            guard let task = alert.textFields!.first?.text else { return }
            UserDefaults.standard.tasks.append(task)
            self.someCollectionView.insertItems(at: [IndexPath(row: UserDefaults.standard.tasks.count - 1, section: 0)])
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
private func setupLayout() {
    view.addSubview(someCollectionView)

    someCollectionView.snp.makeConstraints { make in
        make.top.bottom.equalTo(view.safeAreaLayoutGuide)
        make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
    }
}
}

extension ViewController: UICollectionViewDataSource {
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SomeCollectionViewCell", for: indexPath) as! SomeCollectionViewCell
    return cell
}
}

extension ViewController: UICollectionViewDelegate {}


