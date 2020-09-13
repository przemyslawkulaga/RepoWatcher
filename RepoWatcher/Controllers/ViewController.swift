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
        repositoriesViewModel?.getRepositories()
    }
    
    private func setupTableView() {
        repositoriesTableView.register(UINib(nibName: "RepositoryTableViewCell", bundle: nil), forCellReuseIdentifier: "RepositoryTableViewCell")

        repositoriesTableView.delegate = self
        repositoriesTableView.dataSource = self
        
        repositoriesTableView.rowHeight = UITableView.automaticDimension
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
        return repositoriesViewModel?.filteredRepositories.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryTableViewCell", for: indexPath) as? RepositoryTableViewCell, let repositoryData = repositoriesViewModel?.filteredRepositories[indexPath.row] else { return UITableViewCell() }

        cell.setup(with: repositoryData)
        
        return cell
    }
}

extension ViewController: ArticlesViewModelDelegate {
    func reloadRepositoriesTableView() {
        DispatchQueue.main.async {
            self.repositoriesTableView.reloadData()
        }
    }
}
