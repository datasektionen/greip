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
	var data: [Post] = [] {
		didSet {
			self.tableView.reloadData()
			print("Data set")
		}
	}
		
    override func viewDidLoad() {
        self.tableView.estimatedRowHeight = 200
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reusableCellId) as! FeedCell
        let post = data[indexPath.row]
		
		cell.post = post
        
        cell.separatorInset = UIEdgeInsetsMake(0, 12, 0, 12)
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsZero
        
        return cell
    }

	override func showViewController(vc: UIViewController, sender: AnyObject?) {
		
		let data = (sender as! FeedCell).post
		let detailView = vc as! PostDetailVC
		detailView.post = data
		
		self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
		
		detailView.navigationItem.setLeftBarButtonItem(UIBarButtonItem.init(
			barButtonSystemItem: .Stop, target: detailView, action: #selector(PostDetailVC.close)), animated: false)
		
		navigationController!.pushViewController(vc, animated: false)
	}
}