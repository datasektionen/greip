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
	@IBOutlet fileprivate var meta: UILabel!
	@IBOutlet fileprivate var metaTopConstraint: NSLayoutConstraint!
	@IBOutlet fileprivate var metaBottomConstraint: NSLayoutConstraint!
	@IBOutlet fileprivate var contentBottomConstraint: NSLayoutConstraint!
	var expanded: Bool = false
	var post: Post! {
		didSet {
			content.text = post.content.string
			title.text = post.title
			meta.text = "\(post.author), \(post.date)"
		}
	}

	override func awakeFromNib() {
		super.awakeFromNib()
		content.font = UIFont(name: "Lato-Regular", size: 16)
		self.content.textColor = .label
	}

	override func prepareForReuse() {
		self.expanded = false
		self.meta.isHidden = true
		self.fixExpanded()
	}
	
	func switchExpand() {
		self.expanded = !self.expanded
		self.fixExpanded()
	}

	func fixExpanded() {
		self.content.numberOfLines = self.expanded ? 0 : 3
		self.meta.isHidden = !self.expanded
		self.metaTopConstraint.isActive = self.expanded
		self.metaBottomConstraint.isActive = self.expanded
		self.contentBottomConstraint.isActive = !self.expanded
	}
}
