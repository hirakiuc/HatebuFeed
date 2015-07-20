//
//  FeedCategory.swift
//  HatebuFeed
//
//  Created by Daisuke Hirakiuchi on 2015/07/19.
//  Copyright © 2015年 iapps.altab.jp. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public enum FeedCategoryType: String {
  case HOT = "hot"
  case NEW = "new"
  case TAG = "tag"
}

public enum FeedCategoryName: String {
  case TOTAL = "total"
  case SOCIAL = "social"
  case ECONOMICS = "economics"
  case LIFE = "life"
  case KNOWLEDGE = "knowledge"
  case IT = "it"
  case FUN = "fun"
  case ENTERTAINMENT = "entertainment"
  case GAME = "game"
}

private func uniqueId(type: String, name: String) -> String {
  return String(format: "%@:%@",
    type.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()),
    name.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()))
}

public class FeedCategory : Object {
  dynamic var uid : String = ""
  dynamic var type : String = ""
  dynamic var name : String = ""
  var feedItems = List<FeedItem>()

  // constructor for HotCategory, NewCategory
  convenience init(type: FeedCategoryType, name: FeedCategoryName) {
    self.init()

    self.type = type.rawValue
    self.name = name.rawValue
    self.uid = uniqueId(self.type, name: self.name)
  }

  // constructor for Tag
  convenience init(tag: String) {
    self.init()

    self.type = FeedCategoryType.TAG.rawValue
    self.name = tag
    self.uid = uniqueId(self.type, name: self.name)
  }

  public class func findOrCreate(type: FeedCategoryType, name: String) -> FeedCategory {
    let realm = HatebuFeed.realm()!

    if let category = findBy(realm, type: type, name: name) {
      return category
    }

    realm.write {
      realm.create(FeedCategory.self, value: [
        "uid": uniqueId(type.rawValue, name: name),
        "type": type.rawValue,
        "name": name
      ], update: false)
    }

    return findBy(realm, type: type, name: name)!
  }

  class func findBy(realm: Realm, type: FeedCategoryType, name: String) -> FeedCategory? {
    let result = realm.objects(FeedCategory).filter("uid = %@", uniqueId(type.rawValue, name: name))
    return result.first
  }

  override public class func primaryKey() -> String? {
    return "uid"
  }

  override public class func indexedProperties() -> [String] {
    return ["type", "name"]
  }
}