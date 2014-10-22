//
//  EntityProperties.m
//  cocox2d-box2d
//
//  Created by Laurence Wong on 10/19/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import "EntityProperties.h"

@implementation EntityProperties
@synthesize entityType = entityType_;
@synthesize entityPosition = entityPosition_;

-(id) initWithType:(EntityType)type X:(float)xPos Y:(float)yPos
{
    self = [super init];
    if (self) {
        self.entityPosition = CGPointMake(xPos, yPos);
        self.entityType = type;
    }
    return self;
}

+(EntityType) entityTypeFromInteger:(int)typeInt
{
    switch (typeInt) {
        case 0:
            return SPIKY_ENTITY;
            break;
        case 1:
            return INFINITPWRUP_ENTITY;
            break;
        case 2:
            return SHIELDPWRUP_ENTITY;
            break;
        case 3:
            return METEOR_ENTITY;
            break;
        case 4:
            return MISSILE_ENTITY;
            break;
        default:
            NSLog(@"Invalid BuildingType for integer: %d", typeInt);
            break;
    }
    return nil;
}

@end
