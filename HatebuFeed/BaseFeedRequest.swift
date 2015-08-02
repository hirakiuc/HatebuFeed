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
  var category : FeedCategory { get }
  func feedItems(realm: Realm) -> Results<FeedItem>
  func feedItem(url: String, realm: Realm) -> FeedItem?
  func url() -> (url: String, params: Dictionary<String, String>)

  func fetch(completionHandler: (Array<FeedItem>, NSError?) -> Void) -> Alamofire.Request
  func fetch(parameters: Dictionary<String, String>, completionHandler: (Array<FeedItem>, NSError?) -> Void) -> Alamofire.Request
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

  func fetch(completionHandler: (Array<FeedItem>, NSError?) -> Void) -> Alamofire.Request {
    return fetch([String: String](), completionHandler: completionHandler)
  }

  func fetch(parameters: Dictionary<String, String>, completionHandler: (Array<FeedItem>, NSError?) -> Void) -> Alamofire.Request {

    let req = self.url()

    return Alamofire.request( .GET, req.url, parameters: parameters.merge(req.params))
      .responseFeedItem( { request, response, result in
        switch result {
        case .Failure( _, let error):
          completionHandler(Array<FeedItem>(), error)
          break;
        case .Success(let feedItems):
          self.importFeedItems(self.category, feedItems: feedItems)

          completionHandler(feedItems, nil)
          break;
        }
      })
  }

  func feedItem(url: String, realm: Realm = HatebuFeed.realm()!) -> FeedItem? {
    let category = FeedCategory.findOrCreate(self.category.type, name: self.category.name, realm: realm)
    return category.feedItems.filter("url = %@", url).first
  }

  func feedItems(realm: Realm = HatebuFeed.realm()!) -> Results<FeedItem> {
    let sortDescriptors = [
      SortDescriptor(property: "createdAt", ascending: false),
      SortDescriptor(property: "no", ascending: true)
    ]

    let category = FeedCategory.findOrCreate(self.category.type, name: self.category.name, realm: realm)
    return category.feedItems.sorted(sortDescriptors)
  }

  internal func importFeedItems(category: FeedCategory, feedItems: Array<FeedItem>) -> Bool {
    let realm = HatebuFeed.realm()!

    for feedItem in feedItems {
      realm.write {
        var item = realm.objects(FeedItem).filter("url = %@", feedItem.url).first
        if item == nil {
          realm.add(feedItem)
          item = feedItem
        }

        if item!.isBelongsTo(category) == false {
          let cat = FeedCategory.findOrCreate(category.type, name: category.name, realm: realm)
          cat.feedItems.append(item!)
        }
      }
    }

    return true
  }
}