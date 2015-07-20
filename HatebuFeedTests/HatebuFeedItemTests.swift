//
//  HatebuFeedItemTests.swift
//  HatebuFeed
//
//  Created by Daisuke Hirakiuchi on 2015/07/19.
//  Copyright © 2015年 iapps.altab.jp. All rights reserved.
//

import XCTest
import RealmSwift
@testable import HatebuFeed

class HatebuFeedItemTests: XCTestCase {
  var realm : Realm = Realm(inMemoryIdentifier: "HatebuFeedItemTestsRealm")

  override func setUp() {
    super.setUp()
    // do something
    realm.write { self.realm.deleteAll() }
  }

  override func tearDown() {
    // do something
    realm.write { self.realm.deleteAll() }
    super.tearDown()
  }

  func testSaveWithoutCategory() {
    realm.write {
      for idx in 0..<10 {
        let now = NSDate.new()

        let item = HatebuFeedItem()
        item.title = String(format: "title-%d", idx)
        item.desc = "desc"
        item.url = String(format: "http://b.hatena.ne.jp/%d", idx)
        item.hatebuCount = Int32(idx)
        item.no = Int32(idx)
        item.dcDate = now
        item.dcSubject = "some,subject"
        item.createdAt = now
        item.updatedAt = now
        
        self.realm.add(item)
      }
    }

    XCTAssertEqual(realm.objects(HatebuFeedItem).count, 10)
  }

  func testSaveWithCategory() {
    realm.write {
      let category = HatebuCategory()
      category.type = HatebuCategoryType.HOT.rawValue
      category.name = HatebuCategoryName.IT.rawValue

      self.realm.add(category)

      let now = NSDate.new()
      let item = HatebuFeedItem()
      item.title = "test-title"
      item.desc = "description"
      item.url = "http://b.hatena.ne.jp/test"
      item.hatebuCount = Int32(10)
      item.no = Int32(0)
      item.dcDate = now
      item.dcSubject = "subjectA"
      item.createdAt = now
      item.updatedAt = now
      category.feedItems.append(item)

      self.realm.add(item)
    }

    let feedItems = realm.objects(HatebuFeedItem).filter("url = %@", "http://b.hatena.ne.jp/test")
    XCTAssertEqual(feedItems.count, 1)
    let item = feedItems[0]
    XCTAssertEqual(item.url, "http://b.hatena.ne.jp/test")
  }
}
