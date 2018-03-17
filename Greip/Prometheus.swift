//
//  Prometheus.swift
//  Greip
//
//  Created by Emma Nimstad on 19/5/16.
//  Copyright © 2016 Emma Nimstad. All rights reserved.
//

import Foundation
import UIKit

/// Handles the communication with the news server, Prometheus.
class Prometheus : NSObject {
	static private let timeoutSeconds = 100
	static private let url = URL(string: "https://prometheus.datasektionen.se/api/list/all")!
	static private let lock = NSLock()


	/// Error types for the Prometheus connection.
	struct PrometheusError: Error {
		enum Kind {
			case PendingRequest
			case Timeout
			case JSONError
			case ServerError
		}
		let kind: Kind
	}

	/// Fetch the DataFeed from Prometheus.
	///
	/// - Returns: A list of the posts in the feed. In any case posts in nil,
	///   error will indicate the reason.
	class func fetchFeed() -> (posts: [Post]?, error: PrometheusError?) {
		if !lock.try() {
			// A request is already sent
			return (nil, PrometheusError(kind: .PendingRequest))
		}

		var prometheusError: PrometheusError?
		var JSONData: Data?
		var posts: [Post]?

		let dataTask = URLSession(configuration:.default).dataTask(with: url, completionHandler: {
				(_ data: Data?, response: URLResponse?, error: Error?) in
			if error != nil {
				// The HTTP request failed
				prometheusError = PrometheusError(kind: .ServerError)
			} else {
				JSONData = data
			}
			lock.unlock()
		})
		
		print("Requesting data")
		dataTask.resume()

		// The lock is freed when the dataTask is finished
		if lock.lock(before: Date(timeIntervalSinceNow: TimeInterval(timeoutSeconds))) {
			if prometheusError == nil {
				// Request successfull
				(posts, prometheusError) = parseResponse(JSONData!)
			}
			lock.unlock()
		} else {
			// Timeout
			dataTask.cancel()
			prometheusError = PrometheusError(kind: .Timeout)
			// Free the lock to allow new requests
			lock.unlock()
		}
		return (posts, prometheusError)
    }

	/// Parse the JSON formatted bytes as received from Prometheus.
	private class func parseResponse(_ data: Data) -> ([Post]?, PrometheusError?) {
		if data.isEmpty {
			// This indicates some unknown server error
			return (nil, PrometheusError(kind: .ServerError))
		}

		print("Data received")
		guard let json = try? JSONSerialization.jsonObject(with: data) else {
			// The data is not in valid JSON format
			return (nil, PrometheusError(kind: .JSONError))
		}

		var posts = [Post]()

		for post in json as! [[String: AnyObject]] {
			// TODO: Do not use as!
			let title = post["title_sv"] as! String
			let time = post["publishDate"] as! String
			let author = post["author"] as! String
			let rawcontent = post["content_sv"] as! String

			var content: NSAttributedString
			if let attcontent = try? NSAttributedString(
				data: (rawcontent.data(using: String.Encoding.unicode, allowLossyConversion: true)!),
				options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
				documentAttributes: nil) {
				content = attcontent
			} else {
				// If HTML parsing doesn't work, fallback to show the raw content
				content = NSAttributedString(string:rawcontent)
			}
			posts.append(Post(title: title, date: time, content: content, author: author))

			#if SIMULATOR
				print(title)
				// Don't bother loading all posts as this is very slow in the emulator
				if posts.count >= 10 {
					break
				}
			#endif
		}
		return (posts, nil)
	}
}

