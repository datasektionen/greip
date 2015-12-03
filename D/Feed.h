//
//  Feed.h
//  D
//
//  Created by Emma Nimstad on 24/9/15.
//  Copyright © 2015 Emma Nimstad. All rights reserved.
//

#ifndef Feed_h
#define Feed_h

#import "Post.h"
#import "FeedViewController.h"

@interface Feed : NSObject

@property (nonatomic) NSArray *posts;
@property FeedViewController *fwc;

@end


#endif /* Feed_h */
