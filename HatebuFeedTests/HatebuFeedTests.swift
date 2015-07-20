//
//  HatebuFeedTests.swift
//  HatebuFeedTests
//
//  Created by Daisuke Hirakiuchi on 2015/07/18.
//  Copyright © 2015年 iapps.altab.jp. All rights reserved.
//

import XCTest
import Alamofire
import Ono
import Realm
import RealmSwift
@testable import HatebuFeed

class HatebuFeedTests: XCTestCase {
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  func testConfiguration() {
    let config = HatebuFeed.configuration()
    XCTAssertTrue(config.dynamicType === HatebuFeedConfig.self)
    XCTAssertNotNil(config.realmPath)
  }

  func testConfigure() {
    HatebuFeed.configure({ config in
      config.realmPath = "hoge"
    })
    let config = HatebuFeed.configuration()
    XCTAssertEqual(config.realmPath, "hoge")
  }

  func testHotFeed() {
    let hotFeed = HatebuFeed.HotFeed(FeedCategoryName.TOTAL)

    XCTAssertNotNil(hotFeed)
    XCTAssertTrue(hotFeed.dynamicType === HotFeedRequest.self)
    XCTAssertEqual(hotFeed.name, FeedCategoryName.TOTAL.rawValue)
    XCTAssertNotNil(hotFeed.category)
  }

  func testNewFeed() {
    let newFeed = HatebuFeed.NewFeed(FeedCategoryName.TOTAL)

    XCTAssertNotNil(newFeed)
    XCTAssertTrue(newFeed.dynamicType === NewFeedRequest.self)
    XCTAssertEqual(newFeed.name, FeedCategoryName.TOTAL.rawValue)
    XCTAssertNotNil(newFeed.category)
  }

  func testTag() {
    let tagFeed = HatebuFeed.Tag("swift")

    XCTAssertNotNil(tagFeed)
    XCTAssertTrue(tagFeed.dynamicType === TagFeedRequest.self)
    XCTAssertEqual(tagFeed.name, "swift")
    XCTAssertNotNil(tagFeed.category)
  }
}
