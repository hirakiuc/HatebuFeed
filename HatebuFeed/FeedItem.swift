//
//  FeedItem.swift
//  HatebuFeed
//
//  Created by Daisuke Hirakiuchi on 2015/07/18.
//  Copyright © 2015年 iapps.altab.jp. All rights reserved.
//

import Foundation
import Ono
import Realm
import RealmSwift

public protocol ResponseObjectSerializable {
  init(element: ONOXMLElement)
}

private func formatHatebuCount(text: String) -> Int32 {
  let numberFormatter = NSNumberFormatter()
  numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
  return (numberFormatter.numberFromString(text)?.intValue)!
}

private func formatDcDate(text : String) -> NSDate {
  let dateFormatter = NSDateFormatter()
  dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
  return dateFormatter.dateFromString(text)!
}

public final class FeedItem: Object, ResponseObjectSerializable {
  dynamic var title : String = ""
  dynamic var desc : String = ""
  dynamic var url : String = ""
  dynamic var hatebuCount : Int32 = 0
  dynamic var no : Int32 = 0
  dynamic var dcDate: NSDate = NSDate.new()
  dynamic var dcSubject : String = ""

  dynamic var createdAt : NSDate = NSDate.new()
  dynamic var updatedAt : NSDate = NSDate.new()

  var categories : [FeedCategory] {
    return linkingObjects(FeedCategory.self, forProperty: "feedItems")
  }

  convenience required public init(element: ONOXMLElement) {
    self.init()

    self.title = element.firstChildWithTag("title").stringValue()
    self.desc = element.firstChildWithTag("description").stringValue()
    self.url = element.firstChildWithTag("link").stringValue()

    self.hatebuCount = formatHatebuCount(
      element.firstChildWithTag("bookmarkcount", inNamespace: "hatena").stringValue()
    )

    self.no = 0

    self.dcDate = formatDcDate(
      element.firstChildWithTag("date", inNamespace: "dc").stringValue()
    )

    self.dcSubject = element.firstChildWithTag("subject", inNamespace: "dc").stringValue()
  }

  override public class func primaryKey() -> String? {
    return "url"
  }

  override public class func indexedProperties() -> [String] {
    return ["createdAt", "no"]
  }

  public final func isBelongsTo(category : FeedCategory) -> Bool {
    let list = self.categories.filter { (m) -> Bool in
      return (m.type == category.type && m.name == category.name)
    }
    return (list.count > 0)
  }
}