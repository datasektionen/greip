//
//  Post.swift
//  Greip
//
//  Created by Emma Nimstad on 19/5/16.
//  Copyright © 2016 Emma Nimstad. All rights reserved.
//

import Foundation

let defaultTitle = "Bacon ipsum lorum ipsum"
let defaultContent = "Bacon ipsum dolor amet strip steak doner t-bone chicken tail, picanha leberkas venison sirloin drumstick pastrami ham hock."
var defaultTime = NSDate(timeIntervalSince1970: 1465000000)
var dateFormatterFromServer = NSDateFormatter(), dateFormatterFromDate = NSDateFormatter()

class Post : NSObject {
    let content, time, title: String!
    
    class override func initialize () {
        dateFormatterFromDate.dateStyle = .ShortStyle
		
		dateFormatterFromServer.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    }
    
    init(title: String?, date: String?, content: String?) {
        self.title = title
        self.time = dateFormatterFromDate.stringFromDate(dateFormatterFromServer.dateFromString(date!)!)
        self.content = content
    }
    
    override init () {
        time = dateFormatterFromDate.stringFromDate(defaultTime)
        title = defaultTitle
        content = defaultContent
    }
    
}