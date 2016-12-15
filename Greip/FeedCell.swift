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
	
	var post: Post! {
		didSet {
//			let attributes = content.attributedText?.attributes(at: 0, effectiveRange: nil)
//			let mutableContent = NSMutableAttributedString(attributedString: post.content)
//			mutableContent.addAttributes(attributes!, range: NSRange(location: 0, length: mutableContent.mutableString.length))
			let text = post.content.string
			content.text = text
			title.text = post.title
		}
	}
	
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
