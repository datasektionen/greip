//
//  GetData.swift
//  Greip
//
//  Created by Emma Nimstad on 19/5/16.
//  Copyright © 2016 Emma Nimstad. All rights reserved.
//

import Foundation
import UIKit

class GetData : NSObject {
	
	static fileprivate let urlstring = "https://prometheus.datasektionen.se/api/list/all"
	static fileprivate var navViewController = UINavigationController()
	static fileprivate var feedViewController = FeedViewController()
	
	class func useData(_ data: [Post]?) {
		// Run on the main thread as the UI will be updated
		DispatchQueue.main.async {
			if data != nil {
				print("Using data")
				feedViewController.data = data!
			} else {
				print("No data")
				feedViewController.data = [Post]()
			}
			let appDelegate = UIApplication.shared.delegate as! AppDelegate
			appDelegate.window!.rootViewController = navViewController
		}
	}
	
	class func getData (_ nvc: UINavigationController) {
		var data = [Post]()
		navViewController = nvc
		feedViewController = nvc.viewControllers[0] as! FeedViewController

		let session = URLSession(configuration:.default)
		let url = URL(string: urlstring)!

		let prometheus = session.dataTask(with: url, completionHandler: {
				(_ urldata: Data?, response: URLResponse?, error: Error?) in
			if error != nil {
				print("Error on HTTP request")
				useData(nil)
				return
			}

			print("Data received")
			guard let json = try? JSONSerialization.jsonObject(with: urldata!) else {
				print("Error while parsing JSON")
				useData(nil)
				return
			}

			for post in json as! [[String: AnyObject]] {
				guard let title = post["title_sv"] as? String else { continue }
				guard let time = post["publishDate"] as? String else { continue }
				guard let author = post["author"] as? String else { continue }
				guard let rawcontent = post["content_sv"] as? String else { continue }

				var content: NSAttributedString
				if let attcontent = try? NSAttributedString(
					data: (rawcontent.data(using: String.Encoding.unicode, allowLossyConversion: true)!),
					options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
					documentAttributes: nil) {
					content = attcontent
				} else {
					content = NSAttributedString(string:rawcontent)
				}
				data.append(Post(title: title, date: time, content: content, author: author))
			}
			useData(data)
		})
		
		print("Requesting data")
		prometheus.resume()
		
    }
	
	class func useDummyData () {
		let post = Post()
		let data = Array(repeating: post, count: 7)
		useData(data)
	}
}

