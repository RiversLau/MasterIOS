//
//  BulletNode.h
//  TextShooter
//
//  Created by LiuRivers on 16/7/31.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BulletNode : SKNode

+ (instancetype)bulletFrom:(CGPoint)start toward:(CGPoint)destination;

- (void)applyRecurringForce;

@end
