//
//  PostDetailVC
//  Greip
//
//  Created by Emma Nimstad on 19/6/16.
//  Copyright © 2016 Emma Nimstad. All rights reserved.
//

import Foundation
import UIKit

/// The Controller of the Detailed Post view, which fully shows a Post.
class PostDetailVC : UIViewController {
	@IBOutlet fileprivate var postTitle: UILabel!
	@IBOutlet fileprivate var content: UITextView!
	@IBOutlet fileprivate var meta: UILabel!

	var post: Post!

	override func viewDidLoad() {
		postTitle.text = post.title
		var attributes = content.attributedText.attributes(at: 0, effectiveRange: nil)
		attributes.updateValue(UIFont(name: "Lato-Regular", size: 14)!, forKey: .font)
		let mutableContent = NSMutableAttributedString(attributedString:post.content)
		mutableContent.addAttributes(attributes, range:NSRange(location: 0, length: mutableContent.mutableString.length))

		content.attributedText = mutableContent
		meta.text = "// \(post.author), \(post.date)"
	}
}
