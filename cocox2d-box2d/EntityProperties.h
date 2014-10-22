//
//  EntityProperties.h
//  cocox2d-box2d
//
//  Created by Laurence Wong on 10/19/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum EntityType_t {
    SPIKY_ENTITY,
    INFINITPWRUP_ENTITY,
    SHIELDPWRUP_ENTITY,
    MISSILE_ENTITY,
    METEOR_ENTITY
    
} EntityType;

@interface EntityProperties : NSObject
{
    EntityType entityType_;
    CGPoint entityPosition_;
}

-(id) initWithType:(EntityType)type X:(float)xPos Y:(float)yPos;
+(EntityType) entityTypeFromInteger:(int)typeInt;

@property EntityType entityType;
@property CGPoint entityPosition;


@end
