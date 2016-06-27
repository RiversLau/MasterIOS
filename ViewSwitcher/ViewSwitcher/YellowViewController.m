//
//  YellowViewController.m
//  ViewSwitcher
//
//  Created by LiuRivers on 16/6/26.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "YellowViewController.h"

@interface YellowViewController ()

@end

@implementation YellowViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (IBAction)yellowButtonPressed:(id)sender {
    
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"Yellow View Button Pressed" message:@"You pressed the button one the yellow view" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Yep, I did" style:UIAlertActionStyleDefault handler:nil];
    
    [alertCtrl addAction: action];
    [self presentViewController: alertCtrl animated: YES completion: nil];
}

@end
