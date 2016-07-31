//
//  GameScene.m
//  TextShooter
//
//  Created by LiuRivers on 16/7/30.
//  Copyright (c) 2016年 ShowTime. All rights reserved.
//

#import "GameScene.h"
#import "GameOverScene.h"
#import "PhysicsCategories.h"

@interface GameScene()<SKPhysicsContactDelegate>

@end

@implementation GameScene

+ (instancetype)sceneWithSize:(CGSize)size levelNumber:(NSUInteger)levelNumber {
    
    return [[self alloc] initWithSize:size levelNumber:levelNumber];
}

- (instancetype)initWithSize:(CGSize)size {
    
    return [self initWithSize:size levelNumber:1];
}

- (instancetype)initWithSize:(CGSize)size levelNumber:(NSUInteger)levelNumber {
    
    if (self = [super initWithSize:size]) {
        _levelNumber = levelNumber;
        _playerLives = 5;
        
        self.backgroundColor = [SKColor whiteColor];
        
        SKLabelNode *lives = [SKLabelNode labelNodeWithFontNamed:@"Courier"];
        lives.fontSize = 16;
        lives.fontColor = [SKColor blackColor];
        lives.name = @"LivesLabel";
        lives.text = [NSString stringWithFormat:@"Lives:%lu", _playerLives];
        
        lives.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
        lives.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        lives.position = CGPointMake(self.frame.size.width, self.frame.size.height);
        [self addChild:lives];
        
        SKLabelNode *level = [SKLabelNode labelNodeWithFontNamed:@"Courier"];
        level.fontSize = 16;
        level.fontColor = [SKColor blackColor];
        level.name = @"LevelLabel";
        level.text = [NSString stringWithFormat:@"Level:%lu", _levelNumber];
        level.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
        level.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        level.position = CGPointMake(0, self.frame.size.height);
        [self addChild:level];
        
        _playerNode = [PlayerNode node];
        _playerNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetHeight(self.frame) * 0.1);
        [self addChild:_playerNode];
        
        _enemies = [SKNode node];
        [self addChild:_enemies];
        [self spawnEnemies];
        
        _playerBullets = [SKNode node];
        [self addChild:_playerBullets];
        
        _forceFields = [SKNode node];
        [self addChild:_forceFields];
        [self createForceFields];
        
        self.physicsWorld.gravity = CGVectorMake(0, -1);
        self.physicsWorld.contactDelegate = self;
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if (location.y < CGRectGetHeight(self.frame) * 0.2) {
            CGPoint target = CGPointMake(location.x, self.playerNode.position.y);
            [self.playerNode moveToward:target];
        } else {
            BulletNode *bullet = [BulletNode bulletFrom:self.playerNode.position toward:location];
            [self.playerBullets addChild:bullet];
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    
    if (self.finished) return;
    
    [self updateBullets];
    [self updateEnemies];
    if (![self checkForGameOver]) {
        [self checkForNextLevel];
    }
}

- (void)checkForNextLevel {
    
    if ([self.enemies.children count] == 0) {
        [self gotoNextLevel];
    }
}

- (void)gotoNextLevel {
    
    self.finished = YES;
    
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Courier"];
    label.text = @"Level Complete";
    label.fontColor = [SKColor blueColor];
    label.fontSize = 32;
    label.position = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    [self addChild:label];
    
    GameScene *nextLevel = [[GameScene alloc]initWithSize:self.frame.size levelNumber:self.levelNumber + 1];
    nextLevel.playerLives = self.playerLives;
    [self.view presentScene:nextLevel transition:[SKTransition flipHorizontalWithDuration:1.0]];
}

- (void)updateBullets {
    
    NSMutableArray *bulletsToRemove = [[NSMutableArray alloc]init];
    
    for (BulletNode *bullet in self.playerBullets.children) {
        
        if (!CGRectContainsPoint(self.frame, bullet.position)) {
            
            [bulletsToRemove addObject:bullet];
            continue;
        }
        
        [bullet applyRecurringForce];
    }
    [self.playerBullets removeChildrenInArray:bulletsToRemove];
}

- (void)updateEnemies {
    
    NSMutableArray *enemiesToRemove = [NSMutableArray array];
    
    for (EnemyNode *enemy in self.enemies.children) {
        
        if (!CGRectContainsPoint(self.frame, enemy.position)) {
            [enemiesToRemove addObject:enemy];
            continue;
        }
    }
    
    if (enemiesToRemove.count > 0) {
        [self.enemies removeChildrenInArray:enemiesToRemove];
    }
}

- (void)spawnEnemies {
    
    NSUInteger count = log(self.levelNumber) + self.levelNumber;
    for (NSUInteger i = 0; i < count; i++) {
        
        EnemyNode *enemy = [EnemyNode node];
        CGSize size = self.frame.size;
        CGFloat x = arc4random_uniform(size.width * 0.8) + (size.width * 0.1);
        CGFloat y = arc4random_uniform(size.height * 0.5) + (size.height * 0.5);
        enemy.position = CGPointMake(x, y);
        [self.enemies addChild:enemy];
    }
}

#pragma mark /**************** properties setter method *******************/

- (void)setPlayerLives:(NSUInteger)playerLives {
    
    _playerLives = playerLives;
    SKLabelNode *lives = (id)[self childNodeWithName:@"LivesLabel"];
    lives.text = [NSString stringWithFormat:@"Lives:%lu", _playerLives];
}

#pragma mark /**************** contact delegate ******************/

- (void)didBeginContact:(SKPhysicsContact *)contact {
    
    if (contact.bodyA.categoryBitMask == contact.bodyB.categoryBitMask) {
        // 两种物理对象都属于同一物理类别
        SKNode *nodeA = contact.bodyA.node;
        SKNode *nodeB = contact.bodyB.node;
        
        [nodeA friendlyBumpFrom:nodeB];
        [nodeB friendlyBumpFrom:nodeA];
    } else {
        
        SKNode *attacker = nil;
        SKNode *attackee = nil;
        
        if (contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask) {
            // Body A正在攻击Body B
            attacker = contact.bodyA.node;
            attackee = contact.bodyB.node;
        } else {
            // Body B正在攻击Body A
            attackee = contact.bodyA.node;
            attacker = contact.bodyB.node;
        }
        
        if ([attackee isKindOfClass:[PlayerNode class]]) {
            self.playerLives--;
        }
        
        [attackee receiveAttacker:attacker contact:contact];
        
        [self.playerBullets removeChildrenInArray:@[attacker]];
        [self.enemies removeChildrenInArray:@[attacker]];
    }
}

- (BOOL)checkForGameOver {
    if (self.playerLives == 0) {
        [self triggerGameOver];
        return YES;
    } else {
        return NO;
    }
}

- (void)triggerGameOver {
    
    self.finished = YES;
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"EnemyExplosion" ofType:@"sks"];
    SKEmitterNode *explosion = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    explosion.numParticlesToEmit = 200;
    explosion.position = _playerNode.position;
    [self addChild:explosion];
    
    [_playerNode removeFromParent];
    
    SKScene *gameOver = [[GameOverScene alloc]initWithSize:self.frame.size];
    [self.view presentScene:gameOver transition:[SKTransition doorsOpenVerticalWithDuration:1.0]];
    
    [self runAction:[SKAction playSoundFileNamed:@"gameOver.wav" waitForCompletion:NO]];
}

- (void)createForceFields {
    
    static int fieldCount = 3;
    CGSize size = self.frame.size;
    CGFloat sectionWidth = size.width / fieldCount;
    
    for (NSUInteger i = 0; i < fieldCount; i++) {
        CGFloat x = i * sectionWidth + arc4random_uniform(sectionWidth);
        CGFloat y = arc4random_uniform(size.height * 0.25) + (size.height * 0.25);
        
        SKFieldNode *gravityField = [SKFieldNode radialGravityField];
        gravityField.position = CGPointMake(x, y);
        gravityField.categoryBitMask = GravityFieldCategory;
        gravityField.strength = 4;
        gravityField.falloff = 2;
        gravityField.region = [[SKRegion alloc]initWithSize:CGSizeMake(size.width * 0.3, size.height * 0.1)];
        [self.forceFields addChild:gravityField];
        
        SKLabelNode *fieldLocationNode = [SKLabelNode labelNodeWithFontNamed:@"Courier"];
        fieldLocationNode.fontSize = 16;
        fieldLocationNode.fontColor = [SKColor redColor];
        fieldLocationNode.name = @"GravityField";
        fieldLocationNode.text = @"*";
        fieldLocationNode.position = CGPointMake(x, y);
        [self.forceFields addChild:fieldLocationNode];
    }
}
@end
