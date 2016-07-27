//
//  ViewController.h
//  SlowWorker
//
//  Created by LiuRivers on 16/7/24.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (weak, nonatomic) IBOutlet UITextView *resultsTextView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

