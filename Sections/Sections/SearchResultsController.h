//
//  SearchResultsController.h
//  Sections
//
//  Created by shine-team2 on 16/6/28.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultsController : UITableViewController<UISearchResultsUpdating>

- (instancetype)initWithNames:(NSDictionary *)names keys:(NSArray *)keys;

@end
