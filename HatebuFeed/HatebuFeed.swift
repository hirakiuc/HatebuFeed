//
//  HatebuFeed.swift
//  HatebuFeed
//
//  Created by Daisuke Hirakiuchi on 2015/07/18.
//  Copyright © 2015年 iapps.altab.jp. All rights reserved.
//

import Foundation
import Alamofire
import Ono
import Realm
import RealmSwift

extension Dictionary {
  public func merge(d : Dictionary) -> Dictionary {
    var dict = self

    for (key, value) in d {
      dict[key] = value
    }

    return dict
  }
}

extension Request {
  class func XMLDocumentSerializer() -> Serializer {
    return { request, response, data in
      if data == nil {
        return (nil, nil)
      }

      do {
        let XML: ONOXMLDocument? = try ONOXMLDocument(data: data)
        return (XML, nil)
      } catch {
        return (nil, nil)
      }
    }
  }

  func responseXMLDocument(completionHandler: (NSURLRequest, NSHTTPURLResponse?, ONOXMLDocument?, NSError?) -> Void) -> Self {
    return response(serializer: Request.XMLDocumentSerializer()) { request, response, XML, error in
      completionHandler(request!, response, XML as? ONOXMLDocument, error)
    }
  }

  class func FeedItemSerializer() -> Serializer {
    return { request, response, data in
      if data == nil {
        return ([], nil)
      }

      do {
        let XML : ONOXMLDocument? = try ONOXMLDocument(data: data)
        let elements : Array<ONOXMLElement> = XML?.rootElement.children as! Array<ONOXMLElement>

        let items : Array<HatebuFeedItem> =
          elements.filter({ (element: ONOXMLElement) -> Bool in
            return element.tag == "item"
          }).map({ (element: ONOXMLElement) -> HatebuFeedItem in
            return HatebuFeedItem(element: element)
          })

        return (items, nil)
      } catch {
        return ([], nil)
      }
    }
  }

  func responseFeedItem(completionHandler: (NSURLRequest, NSHTTPURLResponse?, Array<HatebuFeedItem>, NSError?) -> Void) -> Self {
    return response(serializer: Request.FeedItemSerializer()) { request, response, feedItems, error in
      completionHandler(request!, response, feedItems as! Array<HatebuFeedItem>, error)
    }
  }
}

public func configure(configureHandler: (config: HatebuFeedConfig) -> Void) -> Void {
  return configureHandler(config: HatebuFeedConfig.sharedConfig)
}

public func configuration() -> HatebuFeedConfig {
  return HatebuFeedConfig.sharedConfig
}

public func realm() -> Realm? {
  return configuration().realm()
}

public class HotCategory {
  public class func all() -> Array<HatebuCategory> {
    return [HatebuCategory]()
  }
}

public func HotFeed(name: HatebuCategoryName) -> HotFeedRequest {
  return HotFeedRequest(name: name)
}

public class NewCategory {
  public class func all() -> Array<HatebuCategory> {
    return [HatebuCategory]()
  }
}

public func NewFeed(name: HatebuCategoryName) -> NewFeedRequest {
  return NewFeedRequest(name: name)
}

public func Tag(name: String) -> TagFeedRequest {
  return TagFeedRequest(tag: name)
}