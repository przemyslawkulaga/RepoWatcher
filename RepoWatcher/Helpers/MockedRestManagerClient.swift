//
//  MockedRestManagerClient.swift
//  RepoWatcher
//
//  Created by Przemysław Kułaga on 19/09/2020.
//  Copyright © 2020 Przemysław Kułaga. All rights reserved.
//

import Foundation

final class MockedRestManagerClient: RestManager {
    func getGitHubRepositories(completionHandler: @escaping ([UniversalRepositoryModel]?) -> Void) {
        guard let fileUrl = Bundle.main.url(forResource: "gitHubMockedData", withExtension: "json") else {
            completionHandler(nil)
            return
        }
        
        do {
            let data = try Data(contentsOf: fileUrl)
            let decoder = JSONDecoder()
            
            let reposData = try decoder.decode(Array<GitHubRepositoryModel>.self, from: data)
            let unversalRepoData = reposData.map { UniversalRepositoryModel(from: $0) }
            completionHandler(unversalRepoData)
        } catch let error {
            print("[RestManager] \(error)")
            completionHandler(nil)
        }
    }
    
    func getBitBucketRepositories(completionHandler: @escaping ([UniversalRepositoryModel]?) -> Void) {
        guard let fileUrl = Bundle.main.url(forResource: "bitBucketMockedData", withExtension: "json") else {
            completionHandler(nil)
            return
        }
        
        do {
            let data = try Data(contentsOf: fileUrl)
            let decoder = JSONDecoder()
            
            let reposData = try decoder.decode(BitBucketRepositoriesModel.self, from: data)
            let unversalRepoData = reposData.values?.compactMap {
                UniversalRepositoryModel(from: $0)
            }
            completionHandler(unversalRepoData)
        }  catch let error {
            print("[RestManager] \(error)")
            completionHandler(nil)
        }
    }
}
