//
//  UserFeedRequest.swift
//  HatebuFeed
//
//  Created by Daisuke Hirakiuchi on 2015/07/21.
//  Copyright © 2015年 iapps.altab.jp. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public class UserFeedRequest: BaseFeedRequest {
  let category : FeedCategory

  init(userId: String) {
    self.category = FeedCategory.findOrCreate(FeedCategoryType.USER, name: userId)
  }

  public func url() -> (url: String, params: Dictionary<String, String>) {
    return (
      String(format: "%@/%@/rss", self.baseURL, self.category.name),
      ["t": String(format: "%f", NSDate.new().timeIntervalSince1970)]
    )
  }
}