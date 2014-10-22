//
//  PhysicsObjectProperties.h
//  cocox2d-box2d
//
//  Created by Keith DeRuiter on 10/4/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Box2D.h"
//#import "GamePhysicsObject.h"

typedef enum GameObjectType : NSInteger{
    HERO,
    BUILDING,
    SPIKY,
    END_GOAL,
    METEOR,
    INFPWRUP,
    SHLDPWRUP,
    MISSILE
    
} GameObjectType;

@interface PhysicsObjectProperties : NSObject
{
    float mass_;
    float density_;
    float friction_;
    float restitution_;
    b2BodyType type_;
    b2Vec2 boxSize_;
    CGPoint position_;
    BOOL isSensor_;
    GameObjectType objectType_;
}

@property float mass;
@property float density;
@property float friction;
@property float restitution;
@property b2BodyType type;
@property b2Vec2 boxSize;
@property CGPoint position;
@property BOOL isSensor;
@property GameObjectType objectType;

@end
