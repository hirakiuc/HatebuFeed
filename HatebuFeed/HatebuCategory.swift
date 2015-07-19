//
//  HatebuCategory.swift
//  HatebuFeed
//
//  Created by Daisuke Hirakiuchi on 2015/07/19.
//  Copyright © 2015年 iapps.altab.jp. All rights reserved.
//

import Foundation

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

public class HatebuCategory : NSObject {
  let type : String
  let name : String

  // constructor for HotCategory, NewCategory
  init(type: HatebuCategoryType, name: HatebuCategoryName) {
    self.type = type.rawValue
    self.name = name.rawValue
  }

  // constructor for Tag
  init(tag: String) {
    self.type = HatebuCategoryType.TAG.rawValue
    self.name = tag
  }
}