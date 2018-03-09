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
	static fileprivate var data = [Post]()
	static fileprivate var navViewController = UINavigationController()
	static fileprivate var feedViewController = FeedViewController()
	
	class func useData() {
		print("Using data")
		feedViewController.data = data
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		appDelegate.window!.rootViewController = navViewController
	}
	
	class func getData (_ nvc: UINavigationController) {
		navViewController = nvc
		feedViewController = nvc.viewControllers[0] as! FeedViewController
		
		func handlePrometheusResponse(_ urldata: Data?, response: URLResponse?, error: Error?) -> Void {
			if error != nil {
				print("error on http request")
				useDummyData()
				return
			}
			do {
				print("Data received")
				let json = try JSONSerialization.jsonObject(with: urldata!, options: .allowFragments)
				
				for post in json as! [[String: AnyObject]] {
					let title = post["title_sv"] as? String
					print(title!)
					let time = post["publishDate"] as? String

					let rawcontent = post["content_sv"] as? String
					var content: NSAttributedString
					if let attcontent = try? NSAttributedString(
						data: (rawcontent?.data(using: String.Encoding.unicode, allowLossyConversion: true)!)!,
						options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
						documentAttributes: nil) {
							content = attcontent
					} else {
						content = NSAttributedString(string:rawcontent!)
					}
					let author = post["author"] as? String
					
					let postpost = Post(title: title!, date: time!, content: content, author: author!)
					
					data.append(postpost)
				}
				
				let vc = nvc.viewControllers[0] as? FeedViewController
				
				if vc == nil {
					print("nvc has no view...")
					return
				}

				print("Use data")
				DispatchQueue.main.async(execute: useData)
				
			} catch {
				print("error while parsing json")
			}
		}
		
		//let URLSession = Foundation.URLSession(configuration: .default())
		let session = URLSession(configuration:URLSessionConfiguration.default)
		let url = URL(string: urlstring)!
		let prometheus = session.dataTask(with: url, completionHandler: handlePrometheusResponse)
		
		print("Requesting data")
		prometheus.resume()
		
    }
	
	class func useDummyData () {
		let post = Post()
		
		let a = Array(repeating: post, count: 7)
		data = a
		DispatchQueue.main.async(execute: useData)
	}
}

