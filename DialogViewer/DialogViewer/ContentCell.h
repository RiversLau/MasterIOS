//
//  ContentCell.h
//  DialogViewer
//
//  Created by shine-team2 on 16/6/29.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentCell : UICollectionViewCell

@property (strong, nonatomic) UILabel *label;
@property (copy, nonatomic) NSString *text;
@property (assign, nonatomic) CGFloat maxWidth;

+ (CGSize)sizeForContentString:(NSString *)str forMaxWidth:(CGFloat)maxWidth;

@end
