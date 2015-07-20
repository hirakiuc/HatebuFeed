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

private let RealmName : String = "HatebuFeed.realm"

public class HatebuFeedConfig : NSObject {
  static let sharedConfig = HatebuFeedConfig()
  var realmPath : String
  var requestConfiguration : NSURLSessionConfiguration

  override init() {
    self.realmPath = documentPath().stringByAppendingPathComponent(RealmName)
    self.requestConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
  }

  public func realm() -> Realm? {
    do {
      let fileManager = NSFileManager.defaultManager()
      if fileManager.fileExistsAtPath(self.realmPath) {
        try! fileManager.removeItemAtPath(self.realmPath)
      }

      return try Realm(path: self.realmPath)
    } catch {
      return nil
    }
  }
}