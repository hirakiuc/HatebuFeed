//
//  Config.swift
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

public class Config : NSObject {
  static let sharedConfig = Config()
  var realmPath : String
  var requestConfiguration : NSURLSessionConfiguration

  override init() {
    self.realmPath = documentPath().stringByAppendingPathComponent(RealmName)
    self.requestConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
  }

  public func realm() -> Realm? {
    do {
      return try Realm(path: self.realmPath)
    } catch {
      return nil
    }
  }
}