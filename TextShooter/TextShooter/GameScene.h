//
//  GameScene.h
//  TextShooter
//

//  Copyright (c) 2016年 ShowTime. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "PlayerNode.h"
#import "EnemyNode.h"
#import "BulletNode.h"
#import "SKNode+Extra.h"

@interface GameScene : SKScene

@property (assign, nonatomic) NSUInteger levelNumber;

@property (assign, nonatomic) NSUInteger playerLives;

@property (assign, nonatomic) BOOL finished;

@property (strong, nonatomic) PlayerNode *playerNode;

@property (strong, nonatomic) SKNode *enemies;

@property (strong, nonatomic) SKNode *playerBullets;

@property (strong, nonatomic) SKNode *forceFields;

+ (instancetype)sceneWithSize:(CGSize)size levelNumber:(NSUInteger) levelNumber;

- (instancetype)initWithSize:(CGSize)size levelNumber:(NSUInteger) levelNumber;

@end
