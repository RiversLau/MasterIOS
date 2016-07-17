//
//  LanguageListController.h
//  Presidents
//
//  Created by LiuRivers on 16/7/16.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface LanguageListController : UITableViewController

@property (weak, nonatomic) DetailViewController *detailViewController;
@property (copy, nonatomic) NSArray *languageNames;
@property (copy, nonatomic) NSArray *languageCodes;

@end
