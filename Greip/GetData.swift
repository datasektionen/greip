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
	
	class func getData (nvc: UINavigationController) -> Void {
		
		let URLSession = NSURLSession(configuration: .defaultSessionConfiguration())
		
		func handlePrometheusResponse(urldata: NSData?, response: NSURLResponse?, error: NSError?) -> Void {
			if error != nil {
				print("error on http request")
				return
			}
			do {
				print("Data received")
				let json = try NSJSONSerialization.JSONObjectWithData(urldata!, options: .AllowFragments)
				
				for post in json as! [[String: AnyObject]] {
					let title = post["title_sv"] as? String
					let time = post["publishDate"] as? String
					let content = post["content_sv"] as? String
					
					let postpost = Post(title: title, date: time, content: content, author: nil)
					
					data.append(postpost)
				}
				
				let vc = nvc.viewControllers[0] as? FeedViewController
				
				if vc == nil {
					print("nvc has no view...")
					return
				}
				
				dispatch_async(dispatch_get_main_queue(), { () -> Void in
					vc!.data = data
					let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
					appDelegate.window!.rootViewController = nvc
				})
				
			} catch {
				print("error while parsing json")
			}
		}
		
		let prometheus = URLSession.dataTaskWithURL(NSURL(string: url)!,
		                                            completionHandler: handlePrometheusResponse(_:_:_:))
		
		print("Requesting data")
		prometheus.resume()
		
    }
	
	class func getDummyData () -> [Post] {
		let post = Post()
		
		let a = Array(count: 7, repeatedValue: post)
		data = a
		return data
	}
}

