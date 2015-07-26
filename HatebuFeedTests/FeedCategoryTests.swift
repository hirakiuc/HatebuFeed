//
//  FeedCategoryTests.swift
//  HatebuFeed
//
//  Created by Daisuke Hirakiuchi on 2015/07/25.
//  Copyright © 2015年 iapps.altab.jp. All rights reserved.
//

import XCTest
import RealmSwift
@testable import HatebuFeed

class FeedCategoryTests: XCTestCase {
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

  func testCreateOrFind_WithoutRecord() {
    do {
      let realm = self.realm()
      XCTAssertEqual(realm.objects(FeedCategory).count, 0)
    }

    do {
      let realm = self.realm()
      let category = FeedCategory.findOrCreate(FeedCategoryType.HOT.rawValue, name: FeedCategoryName.IT.rawValue)

      XCTAssertEqual(realm.objects(FeedCategory).count, 1)
      let found = realm.objectForPrimaryKey(FeedCategory.self, key: category.uid)
      XCTAssertNotNil(found)
    }
  }

  func testCreateOrFind_WithRecord() {
    do {
      let realm = self.realm()

      realm.write {
        let category = FeedCategory(tag: "swift")
        realm.add(category)
      }

      XCTAssertEqual(realm.objects(FeedCategory).count, 1)
    }

    do {
      let realm = self.realm()
      let category = FeedCategory.findOrCreate(FeedCategoryType.TAG.rawValue, name: "swift")

      XCTAssertEqual(realm.objects(FeedCategory).count, 1)
      let found = realm.objectForPrimaryKey(FeedCategory.self, key: category.uid)
      XCTAssertNotNil(found)
    }
  }
}
