//
//  RepositoriesViewModel.swift
//  RepoWatcher
//
//  Created by Przemysław Kułaga on 12/09/2020.
//  Copyright © 2020 Przemysław Kułaga. All rights reserved.
//

import Foundation

protocol ArticlesViewModelDelegate: class {
    func reloadRepositoriesTableView()
}

final class RepositoriesViewModel {
    // MARK: Variables
    private var restManager = RestManager.shared
    var repos: [UniversalRepositoryModel] = []
    
    weak var delegate: ArticlesViewModelDelegate?
    
    // MARK: Inits
    init(delegate: ArticlesViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK: Functions
    func downloadRepos() {
        restManager.getArticles(completionHandler: { [weak self] data in
            guard let strongSelf = self, let data = data else { return }
            strongSelf.repos = data
            strongSelf.delegate?.reloadRepositoriesTableView()
        })
    }
}
