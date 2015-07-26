//
//  TestsExtension.swift
//  HatebuFeed
//
//  Created by Daisuke Hirakiuchi on 2015/07/26.
//  Copyright © 2015年 iapps.altab.jp. All rights reserved.
//

import XCTest
import RealmSwift
import HatebuFeed

extension XCTestCase {
  final func realm() -> Realm {
    return HatebuFeed.realm()!
  }

  final func clearRealm() {
    let realm = self.realm()
    realm.write { realm.deleteAll() }
  }
}