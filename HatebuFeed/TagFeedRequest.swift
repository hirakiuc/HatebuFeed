//
//  TagFeedRequest.swift
//  HatebuFeed
//
//  Created by Daisuke Hirakiuchi on 2015/07/19.
//  Copyright © 2015年 iapps.altab.jp. All rights reserved.
//

import Foundation

public class TagFeedRequest: BaseFeedRequest {
  let category : HatebuCategory
  let feedPath : String = "search/tag"

  init(tag: String) {
    self.category = HatebuCategory(tag: tag)
  }

  public func url() -> (url: String, params:  Dictionary<String, String>) {
    return (
      String(format: "%@/%@", self.baseURL, self.feedPath),
      ["q": self.category.name, "mode": "rss"]
    )
  }
}