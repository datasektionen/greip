//
//  Post.swift
//  Greip
//
//  Created by Emma Nimstad on 19/5/16.
//  Copyright © 2016 Emma Nimstad. All rights reserved.
//

import Foundation

/// A single item of the DataFeed.
class Post : NSObject {
	let content: NSAttributedString
	let date, title, author: String

	let dateFormatterFromServer = DateFormatter()
	let dateFormatterFromDate = DateFormatter()

	init(title: String, date: String, content: NSAttributedString, author: String) {
		dateFormatterFromDate.dateStyle = .short
		dateFormatterFromServer.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"

		if let d = dateFormatterFromServer.date(from: date) {
			self.date = dateFormatterFromDate.string(from: d)
		} else {
			dateFormatterFromServer.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
			if let d = dateFormatterFromServer.date(from: date) {
				self.date = dateFormatterFromDate.string(from: d)
			} else {
				self.date = ""
			}
		}

        self.title = title
        self.content = content
		self.author = author
    }
}
