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
	
	static let url = "https://prometheus.datasektionen.se/api/list/sv/all"
	static var data = [Post]()
	
	class func getData (vc: FeedViewController) -> Void {
		
		let URLSession = NSURLSession(configuration: .defaultSessionConfiguration())
		
		func handlePrometheusResponse(urldata: NSData?, response: NSURLResponse?, error: NSError?) -> Void {
			if error != nil {
				print("error on http request")
				return
			}
			do {
				let json = try NSJSONSerialization.JSONObjectWithData(urldata!, options: .AllowFragments)
				
				
//				print("parsed data from server is \(json)")
				
				for post in json as! [[String: AnyObject]] {
					let title = post["title_sv"] as? String
					let time = post["publishDate"] as? String
					let content = post["content_sv"] as? String
					
					let postpost = Post(title: title, date: time, content: content)
					
					data.append(postpost)
					
					print(title!)
				}
				
				vc.data = data
				
			} catch {
				print("error while parsing json")
			}
		}
		
		let prometheus = URLSession.dataTaskWithURL(NSURL(string: url)!,
		                                            completionHandler: handlePrometheusResponse(_:_:_:))
		
		prometheus.resume()
		
    }
	
	class func getDummyData () -> [Post] {
		let post = Post()
		
		let a = Array(count: 7, repeatedValue: post)
		data = a
		return data
	}
}

