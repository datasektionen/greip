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
    @IBOutlet private var content: UILabel!
    @IBOutlet private var title: UILabel!
	
	var post: Post! {
		didSet {
			content.text = post.content
			title.text = post.title
		}
	}
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}