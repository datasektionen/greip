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
			// Update UI when data changes
			self.tableView.reloadData()
		}
	}

    override func viewDidLoad() {
        self.tableView.estimatedRowHeight = 70
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableCellId) as! FeedCell
        let post = data[(indexPath as NSIndexPath).row]

		cell.post = post
        return cell
    }

	// Called when a FeedCell wants to present it's corresponding PostDetailVC
	override func show(_ vc: UIViewController, sender: Any?) {
		if let cell = sender as? FeedCell {
			let data = cell.post
			let detailView = vc as! PostDetailVC
			detailView.post = data

			self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)

			//		detailView.navigationItem.setLeftBarButton(UIBarButtonItem.init(
			//			barButtonSystemItem: .stop, target: detailView, action: #selector(PostDetailVC.close)), animated: true)

			navigationController!.pushViewController(vc, animated: true)
		} else {
			// Something else than a FeedCell wants to be presented
		}
	}
}
