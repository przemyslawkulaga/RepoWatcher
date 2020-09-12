//
//  RepositoriesViewModel.swift
//  RepoWatcher
//
//  Created by Przemysław Kułaga on 12/09/2020.
//  Copyright © 2020 Przemysław Kułaga. All rights reserved.
//

import Foundation

final class RepositoriesViewModel {
    // MARK: Variables
    private var restManager = RestManager.shared
    private var reposGitHub: [UniversalRepositoryModel] = []
    
    // MARK: Functions
    func downloadRepos() {
        restManager.getArticles(completionHandler: { [weak self] data in
            guard let strongSelf = self, let data = data else { return }
            strongSelf.reposGitHub = data
        })
    }
}
