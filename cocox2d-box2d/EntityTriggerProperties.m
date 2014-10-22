//
//  EntityTrigger.m
//  cocox2d-box2d
//
//  Created by Laurence Wong on 10/19/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import "EntityTriggerProperties.h"

@implementation EntityTriggerProperties

@synthesize xTrigger = xTrigger_;

-(id) initWithType:(EntityType)type X:(float)xPos Y:(float)yPos Trigger:(int)xTrigger
{
    self = [super initWithType:type X:xPos Y:yPos];
    if (self) {
        self.xTrigger = xTrigger;
    }
    return self;
}

@end
