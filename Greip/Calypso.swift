//
//  Calypso.swift
//  Greip
//
//  Created by Emma Nimstad on 14/11/18.
//  Copyright © 2018 Emma Nimstad. All rights reserved.
//

import Foundation

class Calypso {
	static private let url = URL(string: "https://calypso.datasektionen.se/api/list")!
	static private let timeoutSeconds = 100
	static private let lock = NSLock()


	/// Error types for the Calypso connection.
	struct CalypsoError: Error {
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
	class func fetchFeed() -> (posts: [Post]?, error: CalypsoError?) {
		if !lock.try() {
			// A request is already sent
			return (nil, CalypsoError(kind: .PendingRequest))
		}

		var calypsoError: CalypsoError?
		var JSONData: Data?
		var posts: [Post]?

		let dataTask = URLSession(configuration:.default).dataTask(with: url) { (data, response, error) in
			if error != nil {
				// The HTTP request failed
				calypsoError = CalypsoError(kind: .ServerError)
			} else {
				JSONData = data
			}
			lock.unlock()
		}

		print("Requesting data")
		dataTask.resume()

		// The lock is freed when the dataTask is finished
		if lock.lock(before: Date(timeIntervalSinceNow: TimeInterval(timeoutSeconds))) {
			if calypsoError == nil {
				// Request successfull
				(posts, calypsoError) = parseResponse(JSONData!)
			}
			lock.unlock()
		} else {
			// Timeout
			dataTask.cancel()
			calypsoError = CalypsoError(kind: .Timeout)
			// Free the lock to allow new requests
			lock.unlock()
		}
		return (posts, calypsoError)
	}

	/// Parse the JSON formatted bytes as received from Prometheus.
	private class func parseResponse(_ data: Data) -> ([Post]?, CalypsoError?) {
		if data.isEmpty {
			// This indicates some unknown server error
			return (nil, CalypsoError(kind: .ServerError))
		}

		print("Data received")
		guard let json = try? JSONSerialization.jsonObject(with: data), let parsedjson = json as? [String: Any] else {
			// The data is not in valid JSON format
			return (nil, CalypsoError(kind: .JSONError))
		}

		var posts = [Post]()
		if let jsoncontent = parsedjson["content"] as? [[String: Any]] {
			for post in jsoncontent {
				let title = (post["titleSwedish"] as? String) ?? ""
				let date = (post["publishDate"] as? String) ?? ""
				let author = (post["authorDisplay"] as? String) ?? ""
				let rawcontent = (post["contentSwedish"] as? String) ?? ""

				var content: NSAttributedString
				if let attcontent = try? NSAttributedString(
					data: (rawcontent.data(using: String.Encoding.unicode, allowLossyConversion: true)!),
					options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
					documentAttributes: nil) {
					content = attcontent
				} else {
					// If HTML parsing doesn't work, fallback to show the raw content
					content = NSAttributedString(string: rawcontent)
				}
				content = NSAttributedString(string: content.string.trimmingCharacters(in: .whitespacesAndNewlines))
				posts.append(Post(title: title, date: date, content: content, author: author))

				#if SIMULATOR
				print(title)
				// Don't bother loading all posts as this is very slow in the emulator
				if posts.count >= 10 {
					break
				}
				#endif
			}
		}
		return (posts, nil)
	}
}

