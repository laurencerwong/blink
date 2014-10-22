//
//  Spiky.m
//  cocox2d-box2d
//
//  Created by Student on 10/6/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import "Spiky.h"

@implementation Spiky

+(id) nodeWithPosition:(CGPoint)position
{
    //generate properties
    PhysicsObjectProperties *properties = [[[PhysicsObjectProperties alloc] init]autorelease];
    properties.position = ccp(position.x, position.y);
    properties.type = b2_staticBody;
    properties.friction = 1.0;
    properties.mass = 50.0f;
    properties.density = 50.0f;
    properties.restitution = 0.5f;
    properties.objectType = SPIKY;
    
    
    return [[[self alloc] initWithPhysicsProperties:properties
                                           Filename:@"spikything.png"] autorelease];
}

@end
