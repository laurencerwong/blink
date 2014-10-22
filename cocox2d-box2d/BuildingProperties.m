//
//  BuildingProperties.m
//  cocox2d-box2d
//
//  Created by Keith DeRuiter on 10/8/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import "BuildingProperties.h"

@implementation BuildingProperties

@synthesize buildingType = buildingType_;
@synthesize buildingPosition = buildingPosition_;

-(id) initWithType:(BuildingType)type X:(float)xPos Y:(float)yPos
{
    self = [super init];
    if (self) {
        self.buildingPosition = CGPointMake(xPos, yPos);
        self.buildingType = type;
    }
    return self;
}

+(BuildingType) buildingTypeFromInteger:(int)typeInt
{
    switch (typeInt) {
        case 0:
            return FLAT_GREY;
            break;
        case 1:
            return FLAT_GREEN;
            break;
        case 2:
            return FLAT_BLUE;
            break;
        case 3:
            return SKINNY_BRICK;
            break;
        case 4:
            return FAT_BRICK;
            break;
        case 5:
            return SKINNY_WHITE_BLUE_WINDOW;
            break;
        default:
            NSLog(@"Invalid BuildingType for integer: %d", typeInt);
            break;
    }
    return nil;
}

@end
