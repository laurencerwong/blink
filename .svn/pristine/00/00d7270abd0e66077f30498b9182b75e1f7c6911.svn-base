//
//  GamePhysicsObject.h
//  cocox2d-box2d
//
//  Created by Keith DeRuiter on 10/2/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//



#import "cocos2d.h"
#import "Box2D.h"
#import "CCPhysicsSprite.h"
#import "PhysicsObjectProperties.h"
#import "EntityProperties.h"



@interface GamePhysicsObject : CCPhysicsSprite
{
    GameObjectType objectType_;
    BOOL destroyMe_;
}
@property GameObjectType objectType;
@property BOOL destroyMe;
-(id) initWithPhysicsProperties:(PhysicsObjectProperties *)properties
                       Filename:(NSString*)filename;
-(void) definePhysicsWithProperties:(PhysicsObjectProperties *) properties;
-(void) placeOnTopOfObject:(GamePhysicsObject *)object AtXPosition:(float)x;
@end
