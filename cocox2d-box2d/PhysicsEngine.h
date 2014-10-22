//
//  PhysicsEngine.h
//  cocox2d-box2d
//
//  Created by Laurence Wong on 9/27/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import "CCNode.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "ContactListener.h"
#import "CollisionDetail.h"

#define PTM_RATIO 32
    
@interface PhysicsEngine : CCNode
{
    @public
    b2World *world;
    @private
    GLESDebugDraw *m_debugDraw;		// strong ref
    ContactListener *contactListener;
}

+(PhysicsEngine *)Engine;
-(void)initPhysics;
-(void)deletePhysics;
-(BOOL)hasCollision:(b2Fixture *)fix WithDetails:(NSMutableArray **)details;
-(BOOL)hasCollision:(b2Fixture *)fix;
-(BOOL)areColliding:(b2Fixture *)fixA FixtureB:(b2Fixture*)fixB;
-(void)update:(ccTime)delta;

@end
