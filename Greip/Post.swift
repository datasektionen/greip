//
//  Post.swift
//  Greip
//
//  Created by Emma Nimstad on 19/5/16.
//  Copyright © 2016 Emma Nimstad. All rights reserved.
//

import Foundation

let defaultTitle = "Bacon ipsum lorum ipsum"
let defaultContent = NSAttributedString(string:"Bacon ipsum dolor amet strip steak doner t-bone chicken tail, picanha leberkas venison sirloin drumstick pastrami ham hock.")
let defaultAuthor = "nimstad"
var defaultTime = Date(timeIntervalSince1970: 1465000000)
var dateFormatterFromServer = DateFormatter(), dateFormatterFromDate = DateFormatter()

class Post : NSObject {
	// ligger det krav på att dessa fält alltid finns?
	let content: NSAttributedString
	let time, title, author: String
    
    class override func initialize () {
        dateFormatterFromDate.dateStyle = .short
		
		dateFormatterFromServer.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    }

	init(title: String, date: String, content: NSAttributedString, author: String) {
        self.title = title
        self.time = dateFormatterFromDate.string(from: dateFormatterFromServer.date(from: date)!)
        self.content = content
		self.author = author
    }
    
    override init () {
        time = dateFormatterFromDate.string(from: defaultTime)
        title = defaultTitle
        content = defaultContent
		author = defaultAuthor
    }
    
}
