//
//  BaseFeedRequest.swift
//  HatebuFeed
//
//  Created by Daisuke Hirakiuchi on 2015/07/19.
//  Copyright © 2015年 iapps.altab.jp. All rights reserved.
//

import Foundation
import Alamofire

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
          completionHandler(feedItems, nil)
        }
      })
  }
}