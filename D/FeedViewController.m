//
//  FeedViewController.m
//  Greip
//
//  Created by Emma Nimstad on 24/9/15.
//  Copyright © 2015 Emma Nimstad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedViewController.h"
#import "FeedCollectionCell.h"
#import "Post.h"
#import "GetData.h"

NSString *feedCellID = @"sbfeedcell"; // FeedCell storyboard id

@implementation FeedViewController

// Fetch cell data
-(void) viewDidLoad{
    _data = [GetData getData];
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
//    NSLog(@" i fwc %ld", (unsigned long)[self.data count]);
    return [self.data count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FeedCell *cell = [cv dequeueReusableCellWithReuseIdentifier:feedCellID forIndexPath:indexPath];
    
    Post *post = [self.data objectAtIndex:indexPath.row];
    cell.title.text = post.title;
    cell.text.text = post.text;
    cell.date.text = post.date;
    
//    self.verticalLayoutConstraint.constant = self.collectionView.contentSize.height;
    
    [cell setFrame:CGRectMake(0, cell.frame.origin.y, self.view.window.bounds.size.width, cell.frame.size.height)];
//    [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
//    NSLog(@"%f", );
    CGSize s = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    NSLog(@"%f", s.height);
    
//  Adds a shadow under the cell
    cell.layer.masksToBounds = NO;
    cell.layer.shadowOffset = CGSizeMake(0, 8);
    cell.layer.shadowRadius = 3;
    cell.layer.shadowOpacity = 0.2;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}



@end