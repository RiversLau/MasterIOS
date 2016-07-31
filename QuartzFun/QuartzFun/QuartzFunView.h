//
//  QuartzFunView.h
//  QuartzFun
//
//  Created by LiuRivers on 16/7/28.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface QuartzFunView : UIView

@property (assign, nonatomic) ShapeType shapeType;

@property (assign, nonatomic) BOOL useRandomColor;

@property (strong, nonatomic) UIColor *currentColor;

@end
