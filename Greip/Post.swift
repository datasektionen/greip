//
//  Post.swift
//  Greip
//
//  Created by Emma Nimstad on 19/5/16.
//  Copyright © 2016 Emma Nimstad. All rights reserved.
//

import Foundation

let defaultTitle = "Datasektionens medlemsundersökning 2016"
let defaultContent = "Bacon ipsum dolor amet strip steak doner t-bone chicken tail, picanha leberkas venison sirloin drumstick pastrami ham hock."
var defaultTime = NSDate(timeIntervalSince1970: 1463900000)
var dateFormatterFromServer = NSDateFormatter(), dateFormatterFromDate = NSDateFormatter()

class Post : NSObject {
    let content, time, title: String
    
    class override func initialize () {
        dateFormatterFromServer.dateFormat = "d MMM"
//        dateFormatterFromDate.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatterFromDate.dateStyle = NSDateFormatterStyle.LongStyle
    }
    
    init(title: String, date: String, text: String) {
        self.title = title
        self.time = date
        self.content = text
    }
    
    override init () {
        time = dateFormatterFromDate.stringFromDate(defaultTime)
        title = defaultTitle
        content = defaultContent
    }
    
}