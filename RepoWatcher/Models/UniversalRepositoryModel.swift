//
//  UniversalRepositoryModel.swift
//  RepoWatcher
//
//  Created by Przemysław Kułaga on 12/09/2020.
//  Copyright © 2020 Przemysław Kułaga. All rights reserved.
//

import Foundation

struct UniversalRepositoryModel {
    var repoName: String
    var repoDescription: String?
    var ownerLogin: String
    var ownerAvatar: String?
    
    init(from gitHubRepo: GitHubRepositoryModel) {
        repoName = gitHubRepo.name
        repoDescription = gitHubRepo.description
        ownerLogin = gitHubRepo.owner.login
        ownerAvatar = gitHubRepo.owner.avatar_url
    }
    
    init(from bitBucketRepo: BitBucketRepositoryModel) {
        repoName = bitBucketRepo.name
        repoDescription = bitBucketRepo.description
        ownerLogin = bitBucketRepo.owner.display_name
        ownerAvatar = bitBucketRepo.owner.links?.avatar?.href
    }
}
