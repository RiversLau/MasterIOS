//
//  PhysicsCategories.h
//  TextShooter
//
//  Created by LiuRivers on 16/7/31.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#ifndef PhysicsCategories_h
#define PhysicsCategories_h

typedef NS_OPTIONS(uint32_t, PhysicsCategory) {
    PlayerCategory              = 1 << 1,
    EnemyCategory               = 1 << 2,
    PlayerMissliedCategory      = 1 << 3,
    GravityFieldCategory        = 1 << 4
};

#endif /* PhysicsCategories_h */
