//
//  RepositoriesViewModel.swift
//  RepoWatcher
//
//  Created by Przemysław Kułaga on 12/09/2020.
//  Copyright © 2020 Przemysław Kułaga. All rights reserved.
//

protocol RepositoriesViewModelDelegate: class {
    func reloadRepositoriesTableView()
}

final class RepositoriesViewModel {
    // MARK: Variables
    private var restManager = RestManager()
    
    private var downloadedRepositories: [UniversalRepositoryModel] = []
    
    var filterRepositoryType: RepositoriesTypes?
    var filteredRepositories: [UniversalRepositoryModel]  {
        get {
            switch filterRepositoryType {
            case .gitHub, .bitBucket:
                return downloadedRepositories.filter { $0.type == filterRepositoryType }
            case .nothing:
                return []
            default:
                return downloadedRepositories
            }
        }
    }
    
    weak var delegate: RepositoriesViewModelDelegate?
    
    // MARK: Inits
    init(delegate: RepositoriesViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK: Functions
    func getRepositories() {
        downloadedRepositories = []
        
        restManager.getGitHubRepositories(completionHandler: { [weak self] responseModel in
            guard let strongSelf = self, let gitHubRepo = responseModel else {
                self?.delegate?.reloadRepositoriesTableView()
                return
            }
            
            strongSelf.downloadedRepositories.append(contentsOf: gitHubRepo)
            
            strongSelf.restManager.getBitBucketRepositories(completionHandler: { [weak self] responseModel in
                guard let strongSelf = self, let bitBucketRepo = responseModel else {
                    self?.delegate?.reloadRepositoriesTableView()
                    return
                }
                
                strongSelf.downloadedRepositories.append(contentsOf: bitBucketRepo)
                strongSelf.delegate?.reloadRepositoriesTableView()
            })
        })
    }
}
