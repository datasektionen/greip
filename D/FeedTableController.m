//
//  FeedTableController.m
//  Greip
//
//  Created by Emma Nimstad on 12/5/16.
//  Copyright © 2016 Emma Nimstad. All rights reserved.
//

#import "FeedTableController.h"
#import "FeedCell.h"
#import "Post.h"
#import "GetData.h"

NSString *reusableCellId = @"tablefeedcell";

@implementation FeedTableController {
    NSArray *data;
}

// Fetch cell data
- (void) viewDidLoad{
    data = [GetData getData];
    
    //  Must set the following properties
    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableCellId forIndexPath:indexPath];
    
    Post *post = [data objectAtIndex:indexPath.row];
    cell.title.text = post.title;
    cell.text.text = post.text;
    cell.date.text = post.date;
    
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 12, 0, 12)];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    return cell;
}

@end