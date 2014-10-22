//
//  EndGoal.m
//  cocox2d-box2d
//
//  Created by Keith DeRuiter on 10/6/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import "EndGoal.h"

@implementation EndGoal

-(id) initEndGoalWithPhysicsProperties:(PhysicsObjectProperties *)properties
                              Filename:(NSString*)filename
{
    self = [super initWithPhysicsProperties:properties
                                   Filename:filename];
    if(self)
    {
        
    }
    return self;
}

+(id) nodeWithPosition:(CGPoint)position
{
    
    //generate properties
    PhysicsObjectProperties *properties = [[[PhysicsObjectProperties alloc] init]autorelease];
    properties.position = ccp(position.x, position.y);
    properties.type = b2_staticBody;
    properties.friction = 1.0f;
    properties.mass = 1.0f;
    properties.density = 1.0f;
    properties.restitution = 0.0f;
    properties.isSensor = YES;
    properties.objectType = END_GOAL;
    
    return [[[self alloc] initEndGoalWithPhysicsProperties:properties
                                           Filename:@"Icon-72.png"] autorelease];
}

@end
