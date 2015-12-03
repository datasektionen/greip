//
//  GetData.m
//  D
//
//  Created by Emma Nimstad on 8/10/15.
//  Copyright © 2015 Emma Nimstad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetData.h"

static NSArray<Post *> *data = nil;

@implementation GetData


// HERE WE GET DATA FROM THE SERVER!
+ (NSArray *) getData {
    if(data) return data;
    
    // LIKE THIS
    Post *post = [[Post alloc] initwithDefaults];
    NSArray<Post *> *a = [[NSArray alloc] initWithObjects:post, post, post, post, post, post, post, nil];
    
    data = a;
    return data;
}

@end