//
//  Post.m
//  Greip
//
//  Created by Emma Nimstad on 24/9/15.
//  Copyright © 2015 Emma Nimstad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"

NSDate *defDate;
NSString *defTitle = @"Godmorgon";
NSString *defText = @"Lorem ipsum lotsa aower hawehr aiw uerh liawekbj raiuwe hralekjnlak text alj aie akwej awue lobi oilb k.";
NSDateFormatter *dateFormatterFromServer, *dateFormatterFromDate;

@implementation Post

+ (void)initialize {
    dateFormatterFromServer = [[NSDateFormatter alloc] init];
    dateFormatterFromDate = [[NSDateFormatter alloc] init];
    
//  Change this to match how date is saved on server
    [dateFormatterFromServer setDateFormat:@"d MMM"];//:NSDateFormatterMediumStyle];
    
//  Change this to how the date should be shown
    [dateFormatterFromDate setDateStyle:NSDateFormatterMediumStyle];
    
    defDate = [NSDate dateWithTimeIntervalSince1970:1450000000];
}

- (id) initWith:(NSString *)title :(NSString *)date :(NSString *)text {
    self.title = title;
    self.text = text;
    
    NSDate *postDate = [dateFormatterFromServer dateFromString:date];
    self.date = [dateFormatterFromDate stringFromDate:postDate];
    
    return self;
}

- (id) initwithDefaults {
    
    _date = [dateFormatterFromDate stringFromDate:defDate];
    _title = defTitle;
    _text = defText;
    
    return self;
}

@end