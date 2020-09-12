//
//  ViewController.swift
//  RepoWatcher
//
//  Created by Przemysław Kułaga on 12/09/2020.
//  Copyright © 2020 Przemysław Kułaga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var repositoriesViewModel = RepositoriesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repositoriesViewModel.downloadRepos()
    }
}
