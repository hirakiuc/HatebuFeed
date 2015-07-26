//
//  HotFeed.swift
//  HatebuFeed
//
//  Created by Daisuke Hirakiuchi on 2015/07/18.
//  Copyright © 2015年 iapps.altab.jp. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public class HotFeedRequest: BaseFeedRequest {
  let category : FeedCategory
  let feedPath : String = "hotentry"

  init(name: FeedCategoryName) {
    self.category = FeedCategory.findOrCreate(FeedCategoryType.HOT.rawValue, name: name.rawValue)
  }

  public func url() -> (url: String, params: Dictionary<String, String>) {
    if self.category.name == FeedCategoryName.TOTAL.rawValue {
      return (
        String(format: "%@/%@", self.baseURL, self.feedPath),
        ["mode": "rss"]
      )
    } else {
      return (
        String(format: "%@/%@/%@.rss", self.baseURL, self.feedPath, self.category.name),
        [String: String]()
      )
    }
  }

  public func feedItems(name: FeedCategoryName) -> Results<FeedItem> {
    return loadFeedItems(FeedCategoryType.HOT, name: self.category.name)
  }
}