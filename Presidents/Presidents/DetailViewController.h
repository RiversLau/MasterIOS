//
//  DetailViewController.h
//  Presidents
//
//  Created by LiuRivers on 16/7/3.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

