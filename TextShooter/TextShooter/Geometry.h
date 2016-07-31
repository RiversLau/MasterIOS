//
//  Geometry.h
//  TextShooter
//
//  Created by LiuRivers on 16/7/31.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#ifndef Geometry_h
#define Geometry_h

static inline CGVector VectorMultiply(CGVector v, CGFloat m) {
    
    return CGVectorMake(v.dx * m, v.dy * m);
}

static inline CGVector VectorBetweenPoints(CGPoint p1, CGPoint p2) {
    
    return CGVectorMake(p2.x - p1.x, p2.y - p1.y);
}

static inline CGFloat VectorLength(CGVector v) {
    
    return sqrtf(powf(v.dx, 2) + powf(v.dy, 2));
}

static inline CGFloat PointDistance(CGPoint p1, CGPoint p2) {
    
    return sqrtf(powf(p2.x - p1.x, 2) + powf(p2.y - p1.y, 2));
}

#endif /* Geometry_h */
