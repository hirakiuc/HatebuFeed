//
//  BaseFeedRequest.swift
//  HatebuFeed
//
//  Created by Daisuke Hirakiuchi on 2015/07/19.
//  Copyright © 2015年 iapps.altab.jp. All rights reserved.
//

import Foundation
import Alamofire
import Realm
import RealmSwift

protocol BaseFeedRequest {
  var category : HatebuCategory { get }
  func url() -> (url: String, params: Dictionary<String, String>)
}

extension BaseFeedRequest {
  var baseURL : String {
    get {
      return "http://b.hatena.ne.jp"
    }
  }
  var name : String {
    get {
      return category.name
    }
  }

  func load(completionHandler: (Array<HatebuFeedItem>, NSError?) -> Void) -> Alamofire.Request {
    return load([String: String](), completionHandler: completionHandler)
  }

  func load(parameters: Dictionary<String, String>, completionHandler: (Array<HatebuFeedItem>, NSError?) -> Void) -> Alamofire.Request {

    let req = self.url()

    return Alamofire.request( .GET, URLString: req.url, parameters: parameters.merge(req.params))
      .responseFeedItem( { request, response, feedItems, error in
        if let error = error {
          completionHandler([], error)
        } else {

          self.importFeedItems(self.category, feedItems: feedItems)

          completionHandler(feedItems, nil)
        }
      })
  }

  internal func loadFeedItems(type: HatebuCategoryType, name: String) -> Results<HatebuFeedItem> {
    let realm = HatebuFeed.realm()!

    let sortDescriptors = [
      SortDescriptor(property: "createdAt", ascending: false),
      SortDescriptor(property: "no", ascending: true)
    ]

    return realm.objects(HatebuFeedItem)
      .filter("ANY (categories.type = %@ and categories.name = %@",
        type.rawValue, name
    ).sorted(sortDescriptors)
  }

  internal func importFeedItems(category: HatebuCategory, feedItems: Array<HatebuFeedItem>) -> Bool {
    let realm = HatebuFeed.realm()!

    for feedItem in feedItems {
      realm.write {
        var item = realm.objects(HatebuFeedItem).filter("url = %@", feedItem.url).first
        if item == nil {
          realm.add(feedItem)
          item = feedItem
        }

//        if item?.isBelongsTo(category) == false {
//          category.feedItems.append(item!)
//        }
      }
    }

    return true
  }
}