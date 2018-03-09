//
//  PostDetailVC
//  Greip
//
//  Created by Emma Nimstad on 19/6/16.
//  Copyright © 2016 Emma Nimstad. All rights reserved.
//

import Foundation
import UIKit

class PostDetailVC : UIViewController {
	@IBOutlet fileprivate var postTitle: UILabel!
	@IBOutlet fileprivate var content: UITextView!
	@IBOutlet fileprivate var meta: UILabel!

	var post: Post!

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.automaticallyAdjustsScrollViewInsets = false
	}

	override func viewDidLoad() {
		postTitle.text = post.title
		let attributes = content.attributedText.attributes(at: 0, effectiveRange: nil)
		let mutableContent = NSMutableAttributedString(attributedString:post.content)
		mutableContent.addAttributes(attributes, range:NSRange(location: 0, length: mutableContent.mutableString.length))

		_ = NSAttributedString(string: post.content.string, attributes: attributes)

		content.attributedText = mutableContent		//post.content
		meta.text = "— \(post.author), \(post.time)"
	}
}
