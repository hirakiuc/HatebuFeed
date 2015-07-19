//
//  HatebuFeedItem.swift
//  HatebuFeed
//
//  Created by Daisuke Hirakiuchi on 2015/07/18.
//  Copyright © 2015年 iapps.altab.jp. All rights reserved.
//

import Foundation
import Alamofire
import Ono

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

public final class HatebuFeedItem: ResponseObjectSerializable {
  let title : String
  let desc : String
  let url : String
  let hatebuCount : Int32
  let no : Int32
  let dcDate: NSDate
  let dcSubject : String

  required public init(element: ONOXMLElement) {
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
}