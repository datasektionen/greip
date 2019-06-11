//
//  FeedCell.swift
//  Greip
//
//  Created by Emma Nimstad on 19/5/16.
//  Copyright © 2016 Emma Nimstad. All rights reserved.
//

import Foundation
import UIKit

/// The cell of the DataFeed view, showing one Post in the Feed.
class FeedCell : UITableViewCell {
    @IBOutlet fileprivate var content: UILabel!
    @IBOutlet fileprivate var title: UILabel!
	var expanded: Bool = false

	func switchExpand() {
		self.expanded = !self.expanded
		self.content.numberOfLines = self.expanded ? 0 : 3
	}

	override func awakeFromNib() {
		content.font = UIFont.init(name: "Lato-Regular", size: 16)
	}
	
	var post: Post! {
		didSet {
			content.text = post.content.string
			title.text = post.title
		}
	}
    
}
