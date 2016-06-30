//
//  HeaderCell.m
//  DialogViewer
//
//  Created by shine-team2 on 16/6/30.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "HeaderCell.h"

@implementation HeaderCell

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.label.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.8 alpha:1.0];
        self.label.textColor = [UIColor blackColor];
    }
    
    return self;
}


+ (UIFont *)defaultFont {
    
    return [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}
@end
