//
//  FontListViewController.h
//  Fonts
//
//  Created by shine-team2 on 16/6/29.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FontListViewController : UITableViewController

@property (copy, nonatomic) NSArray *fontNames;

@property (assign, nonatomic) BOOL showFavorites;

@end
