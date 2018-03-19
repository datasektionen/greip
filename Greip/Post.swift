//
//  Post.swift
//  Greip
//
//  Created by Emma Nimstad on 19/5/16.
//  Copyright © 2016 Emma Nimstad. All rights reserved.
//

import Foundation

var dateFormatterFromServer = DateFormatter(), dateFormatterFromDate = DateFormatter()

class Post : NSObject {
	let content: NSAttributedString
	let time, title, author: String
    
	init(title: String, date: String, content: NSAttributedString, author: String) {
		dateFormatterFromDate.dateStyle = .short
		dateFormatterFromServer.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        self.title = title
        self.time = dateFormatterFromDate.string(from: dateFormatterFromServer.date(from: date)!)
        self.content = content
		self.author = author
    }
}
