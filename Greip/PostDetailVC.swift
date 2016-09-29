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
		content.attributedText = post.content
		content.isEditable = false
		meta.text = "— \(post.author), \(post.time)"
	}
	
	func close() {
		print("Will quit detail")
		navigationController?.popViewController(animated: false)
	}
}
