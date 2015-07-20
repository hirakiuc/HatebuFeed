//
//  HatebuFeedConfig.swift
//  HatebuFeed
//
//  Created by Daisuke Hirakiuchi on 2015/07/19.
//  Copyright © 2015年 iapps.altab.jp. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

private func documentPath() -> NSString {
  return NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
}

public class HatebuFeedConfig : NSObject {
  static let sharedConfig = HatebuFeedConfig()
  var realmPath : String
  var requestConfiguration : NSURLSessionConfiguration

  override init() {
    self.realmPath = documentPath().stringByAppendingPathComponent("HatebuFeed.realm")
    self.requestConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
  }

  public func realm() -> Realm? {
    let config = HatebuFeedConfig.sharedConfig
    do {
      let fileManager = NSFileManager.defaultManager()
      if fileManager.fileExistsAtPath(config.realmPath) {
        try! fileManager.removeItemAtPath(config.realmPath)
      }

      return try Realm(path: config.realmPath)
    } catch {
      return nil
    }
  }
}