//
//  BlueViewController.m
//  ViewSwitcher
//
//  Created by LiuRivers on 16/6/26.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "BlueViewController.h"

@interface BlueViewController ()

@end

@implementation BlueViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (IBAction)blueButtonPressed:(id)sender {
    
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"Blue View Button Pressed" message:@"You pressed the button one the bule view" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Yep, I did" style:UIAlertActionStyleDefault handler:nil];
    
    [alertCtrl addAction: action];
    [self presentViewController: alertCtrl animated: YES completion: nil];
}

@end
