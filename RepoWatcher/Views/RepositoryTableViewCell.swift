//
//  RepositoryTableViewCell.swift
//  RepoWatcher
//
//  Created by Przemysław Kułaga on 12/09/2020.
//  Copyright © 2020 Przemysław Kułaga. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var repositoryDescriptionLabel: UILabel!
    @IBOutlet weak var repositoryOwnerAvatar: UIImageView!
    @IBOutlet weak var repositoryOwnerNameLabel: UILabel!
    
    public func setup(with repo: UniversalRepositoryModel) {
        repositoryNameLabel.text = repo.repoName
        repositoryDescriptionLabel.text = repo.repoDescription
        repositoryOwnerNameLabel.text = repo.ownerLogin
        
        if let image = repo.ownerAvatar {
            repositoryOwnerAvatar.image = image
        } else {
            repositoryOwnerAvatar.image = nil
        }
    }
}
