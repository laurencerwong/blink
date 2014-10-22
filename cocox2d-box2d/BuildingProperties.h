//
//  BuildingProperties.h
//  cocox2d-box2d
//
//  Created by Keith DeRuiter on 10/8/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum BuildingType_t {
    FLAT_GREY, FLAT_GREEN, FLAT_BLUE, SKINNY_BRICK, FAT_BRICK, SKINNY_WHITE_BLUE_WINDOW
} BuildingType;

@interface BuildingProperties : NSObject
{
    BuildingType buildingType_;
    CGPoint buildingPosition_;
}

-(id) initWithType:(BuildingType)type X:(float)xPos Y:(float)yPos;
+(BuildingType) buildingTypeFromInteger:(int)typeInt;

@property BuildingType buildingType;
@property CGPoint buildingPosition;

@end
