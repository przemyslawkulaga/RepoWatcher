//
//  UniversalRepositoryModel.swift
//  RepoWatcher
//
//  Created by Przemysław Kułaga on 12/09/2020.
//  Copyright © 2020 Przemysław Kułaga. All rights reserved.
//

import UIKit

enum RepositoriesTypes {
    case gitHub, bitBucket, nothing
}

struct UniversalRepositoryModel {
    var repoName: String
    var repoDescription: String?
    var ownerLogin: String
    var url: String
    var type: RepositoriesTypes
    var ownerAvatar: UIImage?
    
    init(from gitHubRepo: GitHubRepositoryModel) {
        repoName = gitHubRepo.name
        repoDescription = gitHubRepo.description
        ownerLogin = gitHubRepo.owner.login
        url = gitHubRepo.html_url
        type = .gitHub
        
        let avatarURL = gitHubRepo.owner.avatar_url
        if let urlString = avatarURL, let url = URL(string: urlString), let imageData = try? Data(contentsOf: url) {
            ownerAvatar = UIImage(data: imageData)
        }
    }
    
    init(from bitBucketRepo: BitBucketRepositoryModel) {
        repoName = bitBucketRepo.name
        repoDescription = bitBucketRepo.description
        ownerLogin = bitBucketRepo.owner.display_name
        url = bitBucketRepo.owner.links.html.href
        type = .bitBucket
        
        let avatarURL = bitBucketRepo.owner.links.avatar?.href
        if let urlString = avatarURL, let url = URL(string: urlString), let imageData = try? Data(contentsOf: url) {
            ownerAvatar = UIImage(data: imageData)
        }
    }
}
