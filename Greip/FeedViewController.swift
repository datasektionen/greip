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
	var posts: [Post] = [] {
		didSet {
			// Update UI when data changes
			self.tableView.reloadData()
		}
	}

	class func viewController() -> FeedViewController {
		let navController = UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController() as! UINavigationController
		return navController.viewControllers[0] as! FeedViewController
	}

    override func viewDidLoad() {
        self.tableView.estimatedRowHeight = 70
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableCellId) as! FeedCell
        let post = posts[indexPath.row]

		cell.post = post
        return cell
    }

	// Called when a FeedCell wants to present it's corresponding PostDetailVC
	override func show(_ vc: UIViewController, sender: Any?) {
		if let cell = sender as? FeedCell, let detailView = vc as? PostDetailVC{
			detailView.post = cell.post

			navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
			navigationController!.pushViewController(vc, animated: true)
		} else {
			// The method is called unexpectedly
		}
	}

	@IBAction func refresh() {
		self.refreshControl?.endRefreshing()
	}
}
