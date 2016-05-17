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
    
//    [cell setSeparatorInset:<#(UIEdgeInsets)#>]
    
//    [cell setFrame:CGRectMake(0, cell.frame.origin.y, self.view.window.bounds.size.width, cell.frame.size.height)];
    
    //  Adds a shadow under the cell
//    cell.layer.masksToBounds = NO;
//    cell.layer.shadowOffset = CGSizeMake(0, 8);
//    cell.layer.shadowRadius = 3;
//    cell.layer.shadowOpacity = 0.2;
    
    return cell;
}

@end