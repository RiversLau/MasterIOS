//
//  TinyPixDocument.h
//  TinyPix
//
//  Created by LiuRivers on 16/7/18.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TinyPixDocument : UIDocument

- (BOOL)stateAtRow:(NSUInteger)row column:(NSUInteger)column;

- (void)setState:(BOOL)state atRow:(NSUInteger)row column:(NSUInteger)column;

- (void)toggleStateAtRow:(NSUInteger)row column:(NSUInteger)column;

@end
