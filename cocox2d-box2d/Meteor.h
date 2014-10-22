//
//  Meteor.h
//  cocox2d-box2d
//
//  Created by Laurence Wong on 10/19/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import "GamePhysicsObject.h"
#import "PhysicsEngine.h"

@interface Meteor : GamePhysicsObject
{
    CCParticleSystem *flames;
    float speed;
//    BOOL destroyMe_;
}

//@property BOOL destroyMe;
-(void) setParticleSystem:(CCParticleSystem *)inSystem;
-(CCParticleSystem *)getParticleSystem;
+(id) nodeWithPosition:(CGPoint)position TargetPosition:(CGPoint)targetPoint Speed:(float)speed;
@end
