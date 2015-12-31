//
//  GetData.h
//  Greip
//
//  Created by Emma Nimstad on 8/10/15.
//  Copyright © 2015 Emma Nimstad. All rights reserved.
//

#ifndef GetData_h
#define GetData_h

#import <UIKit/UIKit.h>
#import "Post.h"

@interface GetData : NSObject

// Data is fetched from server at first call
+ (NSArray *) getData;

@end


#endif /* GetData_h */
