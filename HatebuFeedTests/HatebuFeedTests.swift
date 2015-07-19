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

  func testExample() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }

  func testHotFeed() {
    let hotFeed = HatebuFeed.HotFeed(HatebuCategoryName.TOTAL)

    XCTAssertNotNil(hotFeed)
    XCTAssertTrue(hotFeed.dynamicType === HotFeedRequest.self)
    XCTAssertEqual(hotFeed.name, HatebuCategoryName.TOTAL.rawValue)
    XCTAssertTrue(hotFeed.category.dynamicType === HatebuCategory.self)
  }

  func testNewFeed() {
    let newFeed = HatebuFeed.NewFeed(HatebuCategoryName.TOTAL)

    XCTAssertNotNil(newFeed)
    XCTAssertTrue(newFeed.dynamicType === NewFeedRequest.self)
    XCTAssertEqual(newFeed.name, HatebuCategoryName.TOTAL.rawValue)
    XCTAssertTrue(newFeed.category.dynamicType === HatebuCategory.self)
  }

  func testTag() {
    let tagFeed = HatebuFeed.Tag("swift")

    XCTAssertNotNil(tagFeed)
    XCTAssertTrue(tagFeed.dynamicType === TagFeedRequest.self)
    XCTAssertEqual(tagFeed.name, "swift")
    XCTAssertTrue(tagFeed.category.dynamicType === HatebuCategory.self)
  }

  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measureBlock {
      // Put the code you want to measure the time of here.
    }
  }
}
