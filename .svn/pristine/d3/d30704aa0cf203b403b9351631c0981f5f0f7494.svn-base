//
//  PowerUp.m
//  cocox2d-box2d
//
//  Created by Laurence Wong on 10/19/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import "PowerUp.h"

@implementation PowerUp
//@synthesize destroyMe = destroyMe_;


-(id) initPowerUpWithPhysicsProperties:(PhysicsObjectProperties *)properties
                               Filename:(NSString *) filename
{
    self = [super initWithPhysicsProperties:properties Filename:filename];
    if (self) {
        [self b2Body]->SetGravityScale(0);
    }
    return self;
}

+(id) nodeWithPosition:(CGPoint)position PowerUpType:(EntityType)pwrUpType
{
    //generate properties
    PhysicsObjectProperties *properties = [[[PhysicsObjectProperties alloc] init]autorelease];
    properties.position = ccp(position.x + 10, position.y);
    properties.type = b2_kinematicBody;
    properties.friction = .8;
    properties.mass = 0.001f;
    properties.density = 1.0f;
    properties.restitution = 0.0f;
    properties.objectType = (pwrUpType == INFINITPWRUP_ENTITY) ? INFPWRUP : SHLDPWRUP;
    
    //Figure out image file
    NSString *filename;
    switch (pwrUpType ) {
        case INFINITPWRUP_ENTITY:
            filename = @"InfinitePowerUp.png";
            break;
        case SHIELDPWRUP_ENTITY:
            filename = @"ShieldPowerUp.png";
            break;
        default:
            filename = @"InfinitePowerUp.png";
            break;
    }
    
    return [[[self alloc] initPowerUpWithPhysicsProperties:properties
                                                   Filename:filename] autorelease];
}

-(void) dealloc
{
    [PhysicsEngine Engine]->world->DestroyBody([self b2Body]);
    //[flames dealloc];
    [super dealloc];
}


@end
