//
//  Post.h
//  D
//
//  Created by Emma Nimstad on 24/9/15.
//  Copyright © 2015 Emma Nimstad. All rights reserved.
//

#ifndef Post_h
#define Post_h

#import <UIKit/UIKit.h>

@interface Post : NSObject

@property NSString *title;
@property NSString *text;
@property NSString *date;

- (id) initWith:(NSString *)title :(NSString *)date :(NSString *)text;
- (id) initwithDefaults;

@end


#endif /* Post_h */
