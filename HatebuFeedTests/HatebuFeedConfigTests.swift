//
//  HatebuFeedConfigTests.swift
//  HatebuFeed
//
//  Created by Daisuke Hirakiuchi on 2015/07/20.
//  Copyright © 2015年 iapps.altab.jp. All rights reserved.
//

import XCTest
@testable import HatebuFeed

class HatebuFeedConfigTests: XCTestCase {
  var config = HatebuFeed.configuration()

  override func setUp() {
    super.setUp()
    // do something
  }

  override func tearDown() {
    // do something
    super.tearDown()
  }

  func testInstance() {
    XCTAssertTrue(config.dynamicType === HatebuFeedConfig.self)

    let otherConfig = HatebuFeed.configuration()
    XCTAssertEqual(self.config, otherConfig)
  }

  func testRealmPath() {
    let path = "testpath"
    self.config.realmPath = path

    let otherConfig = HatebuFeed.configuration()
    XCTAssertEqual(otherConfig.realmPath, path)
  }

  func testRealm() {
    let realm = HatebuFeedConfig.sharedConfig.realm()
    XCTAssertNotNil(realm)
  }
}
