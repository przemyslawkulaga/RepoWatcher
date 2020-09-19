//
//  RepoWatcherTests.swift
//  RepoWatcherTests
//
//  Created by Przemysław Kułaga on 19/09/2020.
//  Copyright © 2020 Przemysław Kułaga. All rights reserved.
//

import XCTest
@testable import RepoWatcher

class RepoWatcherTests: XCTestCase {
    var sut: RepositoriesViewModel!
    
    let mockedGitHubRepos = 100
    let mockedBitBuckedRepos = 10
    let allMockedRepos = 110
    
    override func setUp() {
        super.setUp()
        sut = RepositoriesViewModel(restManager: MockedRestManagerClient())
        sut.getRepositories()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testJSONParsing() {
        XCTAssertEqual(sut.filteredRepositories.count, allMockedRepos, "parsed JSON data does not match mocked data amount in files")
    }
    
    func testRepositoryFiltering() {
        sut.filterRepositoryType = .gitHub
        XCTAssertEqual(sut.filteredRepositories.count, mockedGitHubRepos, "gitHub filtering mismatched")
        
        sut.filterRepositoryType = .bitBucket
        XCTAssertEqual(sut.filteredRepositories.count, mockedBitBuckedRepos, "bitBucket filtering mismatched")
    }
}
