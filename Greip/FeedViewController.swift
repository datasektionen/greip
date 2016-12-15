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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableCellId) as! FeedCell
        let post = data[(indexPath as NSIndexPath).row]

		cell.post = post

        return cell
    }
	
	override func show(_ vc: UIViewController, sender: Any?) {
		print("will show view")

		let data = (sender as! FeedCell).post
		let detailView = vc as! PostDetailVC
		detailView.post = data
		
		self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
//		
//		detailView.navigationItem.setLeftBarButton(UIBarButtonItem.init(
//			barButtonSystemItem: .stop, target: detailView, action: #selector(PostDetailVC.close)), animated: true)
//
		navigationController!.pushViewController(vc, animated: true)
	}
}
