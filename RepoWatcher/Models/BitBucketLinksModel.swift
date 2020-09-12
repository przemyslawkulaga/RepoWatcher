//
//  BitBucketLinksModel.swift
//  RepoWatcher
//
//  Created by Przemysław Kułaga on 12/09/2020.
//  Copyright © 2020 Przemysław Kułaga. All rights reserved.
//

import Foundation

struct BitBucketLinksModel: Codable {
    var html: BitBucketLinkModel
    var avatar: BitBucketLinkModel?
}
