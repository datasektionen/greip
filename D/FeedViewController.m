//
//  FeedViewController.m
//  D
//
//  Created by Emma Nimstad on 24/9/15.
//  Copyright © 2015 Emma Nimstad. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "NSDateFormatter.h"
#import "FeedViewController.h"
#import "FeedCell.h"
#import "Post.h"
#import "GetData.h"

NSString *feedCellID = @"sbfeedcell";               // UICollectionViewCell storyboard id

@implementation FeedViewController

-(void) viewDidLoad{
    _data = [GetData getData];
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    NSLog(@" i fwc %ld", [self.data count]);
    return [self.data count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FeedCell *cell = [cv dequeueReusableCellWithReuseIdentifier:feedCellID forIndexPath:indexPath];
    
    Post *post = [self.data objectAtIndex:indexPath.row];
    cell.title.text = post.title;
    cell.text.text = post.text;
    cell.date.text = post.date;
    
    cell.date.textAlignment = NSTextAlignmentCenter;
//    cell.date.textColor = [UIColor purpleColor];
    
    [cell setFrame:CGRectMake(0, cell.frame.origin.y, self.view.window.bounds.size.width /*cell.frame.size.width*/, cell.frame.size.height)];
//    cell.center.x = self.view.window.center.x;
//    [cell setCenter:CGPointMake(self.view.window.center.x, cell.center.y)];
//    [cell set]
//    [cell.bo]
//    [cell.view ]
//    self.view.window.center.x
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}



@end