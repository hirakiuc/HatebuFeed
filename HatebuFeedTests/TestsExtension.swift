//
//  TestsExtension.swift
//  HatebuFeed
//
//  Created by Daisuke Hirakiuchi on 2015/07/26.
//  Copyright © 2015年 iapps.altab.jp. All rights reserved.
//

import XCTest
import RealmSwift
@testable import HatebuFeed

extension XCTestCase {
  final func realm() -> Realm {
    return HatebuFeed.realm()!
  }

  final func clearRealm() {
    let realm = self.realm()
    realm.write { realm.deleteAll() }
  }

  public func sampleFeedItem(url: String) -> FeedItem {
    let now = NSDate.new()

    let item = FeedItem()
    item.title = "test-title"
    item.desc = "description"
    item.url = url
    item.hatebuCount = Int32(10)
    item.no = Int32(0)
    item.dcDate = now
    item.dcSubject = "subjectA"
    item.createdAt = now
    item.updatedAt = now

    return item
  }
}