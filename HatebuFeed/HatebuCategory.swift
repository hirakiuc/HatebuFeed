//
//  HatebuCategory.swift
//  HatebuFeed
//
//  Created by Daisuke Hirakiuchi on 2015/07/19.
//  Copyright © 2015年 iapps.altab.jp. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public enum HatebuCategoryType: String {
  case HOT = "hot"
  case NEW = "new"
  case TAG = "tag"
}

public enum HatebuCategoryName: String {
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

public class HatebuCategory : Object {
  dynamic var uid : String = ""
  dynamic var type : String = ""
  dynamic var name : String = ""
  var feedItems = List<HatebuFeedItem>()

  // constructor for HotCategory, NewCategory
  convenience init(type: HatebuCategoryType, name: HatebuCategoryName) {
    self.init()

    self.type = type.rawValue
    self.name = name.rawValue
    self.uid = uniqueId(self.type, name: self.name)
  }

  // constructor for Tag
  convenience init(tag: String) {
    self.init()

    self.type = HatebuCategoryType.TAG.rawValue
    self.name = tag
    self.uid = uniqueId(self.type, name: self.name)
  }

  public class func findOrCreate(type: HatebuCategoryType, name: String) -> HatebuCategory {
    let realm = HatebuFeed.realm()!

    if let category = findBy(realm, type: type, name: name) {
      return category
    }

    realm.write {
      realm.create(HatebuCategory.self, value: [
        "uid": uniqueId(type.rawValue, name: name),
        "type": type.rawValue,
        "name": name
      ], update: false)
    }

    return findBy(realm, type: type, name: name)!
  }

  class func findBy(realm: Realm, type: HatebuCategoryType, name: String) -> HatebuCategory? {
    let result = realm.objects(HatebuCategory).filter("uid = %@", uniqueId(type.rawValue, name: name))
    return result.first
  }

  override public class func primaryKey() -> String? {
    return "uid"
  }

  override public class func indexedProperties() -> [String] {
    return ["type", "name"]
  }
}