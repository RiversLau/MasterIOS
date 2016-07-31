//
//  BulletNode.m
//  TextShooter
//
//  Created by LiuRivers on 16/7/31.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "BulletNode.h"
#import "PhysicsCategories.h"
#import "Geometry.h"

@interface BulletNode()

@property (assign, nonatomic) CGVector thrust;

@end

@implementation BulletNode

- (instancetype)init {
    
    if (self = [super init]) {
        
        SKLabelNode *dot = [SKLabelNode labelNodeWithFontNamed:@"Courier"];
        dot.fontColor = [SKColor blackColor];
        dot.fontSize = 40;
        dot.text = @".";
        [self addChild:dot];
        
        SKPhysicsBody *body = [SKPhysicsBody bodyWithCircleOfRadius:1];
        body.dynamic = YES;
        body.categoryBitMask = PlayerMissliedCategory;
        body.collisionBitMask = EnemyCategory;
        body.contactTestBitMask = EnemyCategory;
        body.fieldBitMask = GravityFieldCategory;
        body.mass = 0.01;
        
        self.physicsBody = body;
        self.name = [NSString stringWithFormat:@"Bullet %p", self];
    }
    return self;
}

+ (instancetype)bulletFrom:(CGPoint)start toward:(CGPoint)destination {
    
    BulletNode *bullet = [[self alloc]init];
    
    bullet.position = start;
    
    CGVector movement = VectorBetweenPoints(start, destination);
    CGFloat magnitude = VectorLength(movement);
    if (magnitude == 0.0f) return nil;
    
    CGVector scaleMovement = VectorMultiply(movement, 1 / magnitude);
    CGFloat thrustMagnitude = 100.0;
    bullet.thrust = VectorMultiply(scaleMovement, thrustMagnitude);
    
    [bullet runAction:[SKAction playSoundFileNamed:@"shoot.wav" waitForCompletion:NO]];
    
    return bullet;
}

- (void)applyRecurringForce {
    
    [self.physicsBody applyForce:self.thrust];
}

@end
