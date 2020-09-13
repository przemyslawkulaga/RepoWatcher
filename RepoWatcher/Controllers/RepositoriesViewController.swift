//
//  RepositoriesViewController.swift
//  RepoWatcher
//
//  Created by Przemysław Kułaga on 12/09/2020.
//  Copyright © 2020 Przemysław Kułaga. All rights reserved.
//

import UIKit

final class RepositoriesViewController: UIViewController {
    // MARK: IBOutlets
    @IBOutlet weak var repositoriesTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var gitHubSwitch: UISwitch!
    @IBOutlet weak var bitBucketSwitch: UISwitch!
    
    // MARK: Variables
    private var repositoriesViewModel: RepositoriesViewModel?
    private var refreshControl = UIRefreshControl()
    
    // MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        repositoriesViewModel = RepositoriesViewModel(delegate: self)
        repositoriesViewModel?.getRepositories()
        
        showActivityIndicator(true)
    }
    
    // MARK: Functions
    private func setupTableView() {
        repositoriesTableView.register(UINib(nibName: "RepositoryTableViewCell", bundle: nil), forCellReuseIdentifier: "RepositoryTableViewCell")
        
        repositoriesTableView.delegate = self
        repositoriesTableView.dataSource = self
        
        repositoriesTableView.rowHeight = UITableView.automaticDimension
        repositoriesTableView.estimatedRowHeight = 136
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        repositoriesTableView.addSubview(refreshControl)
        
    }
    
    private func showActivityIndicator(_ show: Bool) {
        show ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        repositoriesTableView.isHidden = show
    }
    
    // MARK: IBActions & Selectors
    @IBAction func repositoriesSwtichValueChanged(_ sender: UISwitch) {
        var filterType: RepositoriesTypes?
        
        switch sender {
        case gitHubSwitch:
            if sender.isOn {
                filterType = bitBucketSwitch.isOn ? nil : .gitHub
            } else {
                filterType = bitBucketSwitch.isOn ? .bitBucket : .nothing
            }
        case bitBucketSwitch:
            if sender.isOn {
                filterType = gitHubSwitch.isOn ? nil : .bitBucket
            } else {
                filterType = gitHubSwitch.isOn ? .gitHub : .nothing
            }
        default:
            break
        }
        
        repositoriesViewModel?.filterRepositoryType = filterType
        reloadRepositoriesTableView()
    }
    
    @objc func refresh(_ sender: AnyObject) {
        repositoriesViewModel?.getRepositories()
    }
}

// MARK: Extensions
extension RepositoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoriesViewModel?.filteredRepositories.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryTableViewCell", for: indexPath) as? RepositoryTableViewCell,
            repositoriesViewModel?.filteredRepositories.indices.contains(indexPath.row) ?? false,
            let repositoryData = repositoriesViewModel?.filteredRepositories[indexPath.row]
            else { return UITableViewCell() }
        
        cell.setup(with: repositoryData)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard
            let vc = storyboard.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController,
            let repositoryData = repositoriesViewModel?.filteredRepositories[indexPath.row]
            else { return }
        
        vc.repositoryData = repositoryData
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true)
    }
}

extension RepositoriesViewController: RepositoriesViewModelDelegate {
    func reloadRepositoriesTableView() {
        DispatchQueue.main.async {
            self.showActivityIndicator(false)
            self.refreshControl.endRefreshing()
            self.repositoriesTableView.reloadData()
        }
    }
}
