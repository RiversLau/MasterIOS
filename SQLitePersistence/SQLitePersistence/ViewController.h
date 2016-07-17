//
//  ViewController.h
//  SQLitePersistence
//
//  Created by LiuRivers on 16/7/17.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *lineFields;

@end

