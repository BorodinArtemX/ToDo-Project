//
//  ViewController.swift
//  MyToDoProject
//
//  Created by Артем Бородин on 21/01/2023.
//

import UIKit
import SnapKit
    
    final class ViewController: UIViewController {
        private lazy var taskTableView: UITableView = {
           let tableView = UITableView()
            tableView.register(SomeCollectionView.self, forCellReuseIdentifier: "TaskTableViewCell")
            tableView.dataSource = self
            tableView.delegate = self
            return tableView
        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            navigationItem.title = "To Do"
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTask))
            setupLayout()
        }
        
        @objc private func addNewTask() {
            print("New task")
            let alert = UIAlertController(title: "New task", message: nil, preferredStyle: .alert)
            alert.addTextField()
            let okAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
                guard let task = alert.textFields!.first?.text else { return }
                UserDefaults.standard.tasks.append(task)
                self.taskTableView.insertRows(at: [IndexPath(row: UserDefaults.standard.tasks.count - 1, section: 0)], with: .automatic)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            present(alert, animated: true)
        }
        
        private func setupLayout() {
            view.addSubview(taskTableView)
            
            taskTableView.snp.makeConstraints { make in
                make.top.bottom.equalTo(view.safeAreaLayoutGuide)
                make.leading.trailing.equalToSuperview().inset(20)
            }
        }
    }

    extension ViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let action = UIContextualAction(style: .normal, title: "Delete") {  _,_,_ in

                UserDefaults.standard.tasks.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            action.backgroundColor = .red
            let swipeConfig = UISwipeActionsConfiguration(actions: [action])
            return swipeConfig
        }
    }

    extension ViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            UserDefaults.standard.tasks.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell") as! SomeCollectionView
            cell.setup(with: UserDefaults.standard.tasks[indexPath.row])
            return cell
        }
        
    }



