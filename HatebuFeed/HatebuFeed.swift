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

private struct Error {
  static let Domain = "jp.altab.iapps.lib.HatebuFeed.error"

  enum Code: Int {
    case DataSerializationFailed = -10000
  }
  static func errorWithCode(code: Code, failureReason: String) -> NSError {
    let userInfo = [NSLocalizedFailureReasonErrorKey: failureReason]
    return NSError(domain: Domain, code: code.rawValue, userInfo: userInfo)
  }
}

// XMLResponse Serialization extension.
extension Request {
  public static func XMLResponseSerializer() -> GenericResponseSerializer<ONOXMLDocument> {
    return GenericResponseSerializer { request, response, data in
      guard let _ = data else {
        let failureReason = "Data could not be serialized. Input data was nil."
        let error = Error.errorWithCode(.DataSerializationFailed, failureReason: failureReason)
        return Alamofire.Result.Failure(data, error)
      }

      do {
        let XML: ONOXMLDocument? = try ONOXMLDocument(data: data)
        return Alamofire.Result.Success(XML!)
      } catch {
        let failureReason = "Data could not be parsed."
        let err = Error.errorWithCode(.DataSerializationFailed, failureReason: failureReason)
        return Alamofire.Result.Failure(nil, err)
      }
    }
  }

  public func responseXMLDocument(completionHandler: (NSURLRequest?, NSHTTPURLResponse?, Alamofire.Result<ONOXMLDocument>) -> Void) -> Self {
    return response(responseSerializer: Request.XMLResponseSerializer(), completionHandler: completionHandler)
  }
}

// FeedItem Serialization extension.
extension Request {
  class func FeedItemSerializer() -> GenericResponseSerializer<Array<FeedItem>> {
    return GenericResponseSerializer<Array<FeedItem>> { request, response, data in
      guard let _ = data else {
        let failureReason = "Data could not be serialized. Input data was nil."
        let error = Error.errorWithCode(.DataSerializationFailed, failureReason: failureReason)
        return Alamofire.Result.Failure(data, error)
      }

      do {
        let XML : ONOXMLDocument? = try ONOXMLDocument(data: data)
        let elements : Array<ONOXMLElement> = XML?.rootElement.children as! Array<ONOXMLElement>

        let items : Array<FeedItem> =
          elements.filter({ (element: ONOXMLElement) -> Bool in
            return element.tag == "item"
          }).map({ (element: ONOXMLElement) -> FeedItem in
            return FeedItem(element: element)
          })

        return Alamofire.Result.Success(items)
      } catch {
        let failureReason = "Data could not parsed."
        let err = Error.errorWithCode(.DataSerializationFailed, failureReason: failureReason)
        return Alamofire.Result.Failure(nil, err)
      }
    }
  }

  func responseFeedItem(completionHandler: (NSURLRequest?, NSHTTPURLResponse?, Alamofire.Result<Array<FeedItem>>) -> Void) -> Self {
    return response(responseSerializer: Request.FeedItemSerializer(), completionHandler: { request, response, result in
      completionHandler(request, response, result)
    })
  }
}

public func configure(configureHandler: (config: Config) -> Void) -> Void {
  return configureHandler(config: Config.sharedConfig)
}

public func configuration() -> Config {
  return Config.sharedConfig
}

public func realm() -> Realm? {
  return configuration().realm()
}

public class HotCategory {
  public class func all() -> Array<FeedCategory> {
    return [FeedCategory]()
  }
}

public class NewCategory {
  public class func all() -> Array<FeedCategory> {
    return [FeedCategory]()
  }
}

public func HotFeed(name: FeedCategoryName) -> HotFeedRequest {
  return HotFeedRequest(name: name)
}

public func NewFeed(name: FeedCategoryName) -> NewFeedRequest {
  return NewFeedRequest(name: name)
}

public func TagFeed(name: String) -> TagFeedRequest {
  return TagFeedRequest(tag: name)
}

public func UserFeed(userId: String) -> UserFeedRequest {
  return UserFeedRequest(userId: userId)
}
