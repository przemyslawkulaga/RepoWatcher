//
//  ViewController.swift
//  RepoWatcher
//
//  Created by Przemysław Kułaga on 12/09/2020.
//  Copyright © 2020 Przemysław Kułaga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var repositoriesTableView: UITableView!
    
    private var repositoriesViewModel: RepositoriesViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        repositoriesViewModel = RepositoriesViewModel(delegate: self)
        repositoriesViewModel?.downloadRepos()
    }
    
    private func setupTableView() {
        repositoriesTableView.register(UINib(nibName: "RepositoryTableViewCell", bundle: nil), forCellReuseIdentifier: "RepositoryTableViewCell")

        repositoriesTableView.delegate = self
        repositoriesTableView.dataSource = self
        
        repositoriesTableView.rowHeight = 136
        repositoriesTableView.estimatedRowHeight = 136
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "WebViewController")
//        let navController = UINavigationController(rootViewController: vc)
//        self.present(navController, animated: true)
//    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoriesViewModel?.repos.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryTableViewCell", for: indexPath) as? RepositoryTableViewCell, let repositoryData = repositoriesViewModel?.repos[indexPath.row] else { return UITableViewCell() }

        cell.setup(with: repositoryData)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ViewController: ArticlesViewModelDelegate {
    func reloadRepositoriesTableView() {
        DispatchQueue.main.async {
            self.repositoriesTableView.reloadData()
        }
    }
}
