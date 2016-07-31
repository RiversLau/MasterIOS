//
//  SKNode+Extra.h
//  TextShooter
//
//  Created by LiuRivers on 16/7/31.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKNode (Extra)

- (void)receiveAttacker:(SKNode *)attacker contact:(SKPhysicsContact *)contact;

- (void)friendlyBumpFrom:(SKNode *)node;

@end
