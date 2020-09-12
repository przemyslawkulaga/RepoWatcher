//
//  GitHubOwnerModel.swift
//  RepoWatcher
//
//  Created by Przemysław Kułaga on 12/09/2020.
//  Copyright © 2020 Przemysław Kułaga. All rights reserved.
//

import Foundation

struct GitHubOwnerModel: Codable {
    var login: String
    var avatar_url: String?
}
