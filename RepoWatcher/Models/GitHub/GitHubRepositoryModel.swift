//
//  GitHubRepositoryModel.swift
//  RepoWatcher
//
//  Created by Przemysław Kułaga on 12/09/2020.
//  Copyright © 2020 Przemysław Kułaga. All rights reserved.
//

struct GitHubRepositoryModel: Codable {
    var name: String
    var description: String?
    var html_url: String
    var owner: GitHubOwnerModel
}
