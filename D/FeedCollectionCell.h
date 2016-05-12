//
//  FeedCell.h
//  Greip
//
//  Created by Emma Nimstad on 24/9/15.
//  Copyright © 2015 Emma Nimstad. All rights reserved.
//

#ifndef FeedCell_h
#define FeedCell_h

#import <UIKit/UIKit.h>

@interface FeedCollectionCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *text;
@property (strong, nonatomic) IBOutlet UILabel *date;

@end


#endif /* FeedCell_h */
