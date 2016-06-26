//
//  PostDetailSegue.swift
//  Greip
//
//  Created by Emma Nimstad on 19/6/16.
//  Copyright © 2016 Emma Nimstad. All rights reserved.
//

import Foundation
import UIKit

class PostDetailSegue: UIStoryboardSegue {
	
	override func perform() {
		let source = self.sourceViewController as! FeedViewController
		let dest = self.destinationViewController
		
		source.showViewController(dest, sender: source.data)
	}
}
