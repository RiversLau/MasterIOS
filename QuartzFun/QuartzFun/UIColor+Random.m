//
//  UIColor+Random.m
//  QuartzFun
//
//  Created by LiuRivers on 16/7/28.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "UIColor+Random.h"

@implementation UIColor (Random)

+ (UIColor *)randomColor {
    
    CGFloat red = (arc4random() % 256) / 255;
    CGFloat blue = (arc4random() % 256) / 255;
    CGFloat green = (arc4random() % 256) / 255;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

@end
