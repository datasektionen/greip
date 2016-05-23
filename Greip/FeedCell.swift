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
    @IBOutlet var time: UILabel!
    @IBOutlet var content: UILabel!
    @IBOutlet var title: UILabel!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}