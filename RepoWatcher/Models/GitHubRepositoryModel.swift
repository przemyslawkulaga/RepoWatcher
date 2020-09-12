//
//  GitHubRepositoryModel.swift
//  RepoWatcher
//
//  Created by Przemysław Kułaga on 12/09/2020.
//  Copyright © 2020 Przemysław Kułaga. All rights reserved.
//

import Foundation

struct GitHubRepositoryModel: Codable {
    var id: Int
    var name: String
    var description: String?
    var owner: GitHubOwnerModel
}
