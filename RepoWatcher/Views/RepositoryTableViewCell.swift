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
        repositoryOwnerAvatar.layer.cornerRadius = 25
        repositoryOwnerAvatar.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        repositoryOwnerAvatar.layer.borderWidth = 1

        repositoryNameLabel.text = repo.repoName
        repositoryDescriptionLabel.text = repo.repoDescription
        repositoryOwnerNameLabel.text = repo.ownerLogin
        
        if let image = repo.ownerAvatar {
            repositoryOwnerAvatar.isHidden = false
            repositoryOwnerAvatar.image = image
        } else {
            repositoryOwnerAvatar.isHidden = true
            repositoryOwnerAvatar.image = nil
        }
    }
}
