//
//  RepositoryTableViewCell.swift
//  RepoWatcher
//
//  Created by Przemysław Kułaga on 12/09/2020.
//  Copyright © 2020 Przemysław Kułaga. All rights reserved.
//

import UIKit

final class RepositoryTableViewCell: UITableViewCell {
    // MARK: IBOutlets
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var repositoryDescriptionLabel: UILabel!
    @IBOutlet weak var repositoryOwnerAvatar: UIImageView!
    @IBOutlet weak var repositoryOwnerNameLabel: UILabel!
    
    // MARK: Functions
    public func setup(with repo: UniversalRepositoryModel) {
        repositoryOwnerAvatar.layer.cornerRadius = 25
        repositoryOwnerAvatar.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        repositoryOwnerAvatar.layer.borderWidth = 1
        repositoryOwnerAvatar.isHidden = repo.ownerAvatar == nil
        repositoryOwnerAvatar.image = repo.ownerAvatar
        
        repositoryOwnerNameLabel.text = repo.ownerLogin
        repositoryNameLabel.text = repo.repoName
        repositoryDescriptionLabel.text = repo.repoDescription
    }
}
