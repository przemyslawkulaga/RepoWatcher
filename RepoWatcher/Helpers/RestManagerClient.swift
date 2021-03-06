//
//  RestManagerClient.swift
//  RepoWatcher
//
//  Created by Przemysław Kułaga on 12/09/2020.
//  Copyright © 2020 Przemysław Kułaga. All rights reserved.
//

import Foundation

protocol RestManager {
    func getGitHubRepositories(completionHandler: @escaping ([UniversalRepositoryModel]?) -> Void)
    func getBitBucketRepositories(completionHandler: @escaping ([UniversalRepositoryModel]?) -> Void)
}

final class RestManagerClient: RestManager {
    // MARK: Variables
    private let urlGitHub = "https://api.github.com/repositories"
    private let urlBitBucket = "https://api.bitbucket.org/2.0/repositories?fields=values.name,values.owner,values.description"
    
    // MARK: Functions
    func getGitHubRepositories(completionHandler: @escaping ([UniversalRepositoryModel]?) -> Void) {
        guard let url = URL(string: urlGitHub) else {
            completionHandler(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            guard let responseData = data else {
                completionHandler(nil)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let reposData = try decoder.decode(Array<GitHubRepositoryModel>.self, from: responseData)
                let unversalRepoData = reposData.map { UniversalRepositoryModel(from: $0) }
                completionHandler(unversalRepoData)
            } catch let error {
                print("[RestManager] \(error)")
                completionHandler(nil)
            }
        })
        
        task.resume()
    }
    
    func getBitBucketRepositories(completionHandler: @escaping ([UniversalRepositoryModel]?) -> Void) {
        guard let url = URL(string: urlBitBucket) else {
            completionHandler(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            guard let responseData = data else {
                completionHandler(nil)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let reposData = try decoder.decode(BitBucketRepositoriesModel.self, from: responseData)
                let unversalRepoData = reposData.values?.compactMap {
                    UniversalRepositoryModel(from: $0)
                }
                completionHandler(unversalRepoData)
            } catch let error {
                print("[RestManager] \(error)")
                completionHandler(nil)
            }
        })
        
        task.resume()
    }
}
