//
//  NewFeedRequest.swift
//  HatebuFeed
//
//  Created by Daisuke Hirakiuchi on 2015/07/19.
//  Copyright © 2015年 iapps.altab.jp. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public class NewFeedRequest: BaseFeedRequest {
  let category : FeedCategory
  let feedPath : String = "entrylist"

  init(name: FeedCategoryName) {
    self.category = FeedCategory.findOrCreate(FeedCategoryType.NEW, name: name.rawValue)
  }

  public func url() -> (url: String, params: Dictionary<String, String>) {
    if self.category.name == FeedCategoryName.TOTAL.rawValue {
      return (
        String(format: "%@/%@", self.baseURL, self.feedPath),
        ["mode": "rss"]
      )
    } else {
      return (
        String(format: "%@/%@/%@", self.baseURL, self.feedPath, self.category.name),
        ["mode": "rss"]
      )
    }
  }

  public  func feedItems(name: FeedCategoryName) -> Results<FeedItem> {
    return loadFeedItems(FeedCategoryType.NEW, name: self.category.name)
  }
}