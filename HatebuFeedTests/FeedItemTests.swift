//
//  FeedItemTests.swift
//  HatebuFeed
//
//  Created by Daisuke Hirakiuchi on 2015/07/19.
//  Copyright © 2015年 iapps.altab.jp. All rights reserved.
//

import XCTest
import RealmSwift
@testable import HatebuFeed

class FeedItemTests: XCTestCase {

  override func setUp() {
    super.setUp()

    // do something
    self.clearRealm()
  }

  override func tearDown() {
    // do something
    self.clearRealm()

    super.tearDown()
  }

  func feedItem(idx: Int = 0, now: NSDate = NSDate.new()) -> FeedItem {
    let item = FeedItem()
    item.title = String(format: "title-%d", idx)
    item.desc = "desc"
    item.url = String(format: "http://b.hatena.ne.jp/%d", idx)
    item.hatebuCount = Int32(idx)
    item.no = Int32(idx)
    item.dcDate = now
    item.dcSubject = "some,subject"
    item.createdAt = now
    item.updatedAt = now

    return item
  }

  func testSaveWithoutCategory() {
    let realm = self.realm()

    realm.write {
      for idx in 0..<10 {
        realm.add(self.feedItem(idx))
      }
    }

    XCTAssertEqual(realm.objects(FeedItem).count, 10)
  }

  func testSaveWithCategory() {
    let realm = self.realm()

    realm.write {
      let category = FeedCategory()
      category.type = FeedCategoryType.HOT.rawValue
      category.name = FeedCategoryName.IT.rawValue

      realm.add(category)

      let now = NSDate.new()
      let item = FeedItem()
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

      realm.add(item)
    }

    let feedItems = realm.objects(FeedItem).filter("url = %@", "http://b.hatena.ne.jp/test")
    XCTAssertEqual(feedItems.count, 1)
    let item = feedItems[0]
    XCTAssertEqual(item.url, "http://b.hatena.ne.jp/test")
  }

  func testIsBelongsTo() {
    let realm = self.realm()

    realm.write {
      let category = FeedCategory(type: FeedCategoryType.HOT, name: FeedCategoryName.IT)
      realm.add(category)

      let item = self.feedItem()
      category.feedItems.append(item)
      realm.add(item)
    }

    let category = realm.objects(FeedCategory).filter("type = %@ and name = %@", FeedCategoryType.HOT.rawValue, FeedCategoryName.IT.rawValue).first!
    let item = realm.objects(FeedItem).filter("url = %@", "http://b.hatena.ne.jp/0").first!
    XCTAssertTrue(item.isBelongsTo(category))
  }
}