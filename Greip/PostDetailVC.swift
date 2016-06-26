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
	@IBOutlet private var postTitle: UILabel!
	@IBOutlet private var content: UILabel!
	@IBOutlet private var meta: UILabel!
	
	var post: Post!
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func viewDidLoad() {
		postTitle.text = post.title
		content.text = post.content
		meta.text = "Postat av \(post.author), \(post.time)"
	}
	
	func close() {
		print("Will quit detail")
		navigationController?.popViewControllerAnimated(false)
	}
}
