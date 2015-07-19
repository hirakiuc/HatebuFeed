//
//  NewFeedRequest.swift
//  HatebuFeed
//
//  Created by Daisuke Hirakiuchi on 2015/07/19.
//  Copyright © 2015年 iapps.altab.jp. All rights reserved.
//

import Foundation

public class NewFeedRequest: BaseFeedRequest {
  let category : HatebuCategory
  let feedPath : String = "entrylist"

  init(name: HatebuCategoryName) {
    self.category = HatebuCategory(type: HatebuCategoryType.NEW, name: name)
  }

  public func url() -> (url: String, params: Dictionary<String, String>) {
    if self.category.name == HatebuCategoryName.TOTAL.rawValue {
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
}