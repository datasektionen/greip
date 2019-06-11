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

/// The Controller of the DataFeed view.
///
/// The DataFeed consists of a list of Posts, which is presented as a UITableView of FeedCells.
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
        self.tableView.rowHeight = UITableView.automaticDimension
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

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let cell = tableView.cellForRow(at: indexPath) as! FeedCell
		print(cell.post.title)
		tableView.performBatchUpdates({
			cell.switchExpand()
		})
	}

	@IBAction func refresh() {
		self.refreshControl?.endRefreshing()
	}
}
