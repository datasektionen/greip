//
//  FeedViewController.swift
//  Greip
//
//  Created by Emma Nimstad on 19/5/16.
//  Copyright © 2016 Emma Nimstad. All rights reserved.
//

import Foundation
import UIKit

var reusableCellId = "tablefeedcell"

class FeedViewController : UITableViewController {
	internal var data: [Post] = [] {
		didSet {
			self.tableView.reloadData()
//			self.reloadInputViews()
			
//			print("number of posts: \(data.count)")
		}
	}
		
    override func viewDidLoad() {
		GetData.getData(self)
		
        self.tableView.estimatedRowHeight = 200
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reusableCellId) as! FeedCell
        let post = data[indexPath.row]
        
        cell.title.text = post.title
        cell.content.text = post.content
        cell.time.text = post.time
        
        cell.separatorInset = UIEdgeInsetsMake(0, 12, 0, 12)
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsZero
        
        return cell
    }
}