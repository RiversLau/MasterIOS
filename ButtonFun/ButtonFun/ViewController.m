//
//  ViewController.m
//  ButtonFun
//
//  Created by shine-team2 on 16/6/20.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation ViewController

- (IBAction)buttonPressed:(UIButton *)sender {
    
    NSString *title = [sender titleForState: UIControlStateNormal];
    NSString *plainText = [NSString stringWithFormat: @"%@ button pressed.", title];
//    _statusLabel.text = plainText;
    
    NSMutableAttributedString *styleText = [[NSMutableAttributedString alloc]initWithString:plainText];
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont boldSystemFontOfSize: _statusLabel.font.pointSize]};
    NSRange nameRange = [plainText rangeOfString: title];
    [styleText setAttributes: attributes range: nameRange];
    
    _statusLabel.attributedText = styleText;
}


@end
