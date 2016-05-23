//
//  GetData.swift
//  Greip
//
//  Created by Emma Nimstad on 19/5/16.
//  Copyright © 2016 Emma Nimstad. All rights reserved.
//

import Foundation

class GetData : NSObject {
    static var data: NSArray?
    
    class func getData () -> NSArray {
        if data != nil {
            return data!
        }
        let post = Post()

        let a = [post, post, post, post, post, post, post, post]
        data = a
        return data!
    }
}

