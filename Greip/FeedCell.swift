//
//  FeedCell.swift
//  Greip
//
//  Created by Emma Nimstad on 19/5/16.
//  Copyright © 2016 Emma Nimstad. All rights reserved.
//

import Foundation
import UIKit


class FeedCell : UITableViewCell {
    @IBOutlet fileprivate var content: UILabel!
    @IBOutlet fileprivate var title: UILabel!

	override func awakeFromNib() {
		content.font = UIFont.init(name: "Lato-Regular", size: 16)
	}
	
	var post: Post! {
		didSet {
			let text = post.content.string
			content.text = text
			title.text = post.title
		}
	}
    
}
