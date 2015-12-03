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
//    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FeedCell *cell = [cv dequeueReusableCellWithReuseIdentifier:feedCellID forIndexPath:indexPath];
    
//    cell.text.text = @"Lotsa lotsa lotsa aower hawehr aiw uerh liawekbj raiuwe hralekjnlak text alj aie akwej awue lobi oilb k serbafkjshbf iluhse ijher kjn gswer uijngs.";
//    
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    [dateFormat setDateFormat:@"MMM dd yyyy"];
//    cell.date.text = [dateFormat stringFromDate:[NSDate date]];
    Post *post = [self.data objectAtIndex:indexPath.row];
    cell.title.text = post.title;
    cell.text.text = post.text;
    cell.date.text = post.date;
    
    [cell setFrame:CGRectMake(cell.frame.origin.x, cell.frame.origin.y, [self.win], cell.frame.size.height)];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    [[self presentingViewController] performSelector:@selector(chooseEmoji:) withObject:[emojiz substringWithRange:NSMakeRange(2*indexPath.row, 2)]];
//    [[self presentingViewController] dismissViewControllerAnimated:NO completion:nil];
}



@end