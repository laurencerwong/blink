//
//  Building.m
//  cocox2d-box2d
//
//  Created by Keith DeRuiter on 9/30/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import "Building.h"


@implementation Building

-(id) initBuildingWithPhysicsProperties:(PhysicsObjectProperties *)properties
                               Filename:(NSString *) filename
{
    self = [super initWithPhysicsProperties:properties Filename:filename];
    if (self) {
        self.position = ccp(self.position.x + self.contentSize.width/2,
                            self.position.y - self.contentSize.height/2);
    }
    return self;
}


+(id) nodeWithPosition:(CGPoint)position BuildingType:(BuildingType)buildingType
{
    //generate properties
    PhysicsObjectProperties *properties = [[[PhysicsObjectProperties alloc] init]autorelease];
    properties.position = ccp(position.x, position.y);
    properties.type = b2_staticBody;
    properties.friction = .8;
    properties.mass = 1.0f;
    properties.density = 1.0f;
    properties.restitution = 0.0f;
    properties.objectType = BUILDING;
    
    //Figure out image file
    NSString *filename;
    switch (buildingType) {
        case FLAT_GREY:
            filename = @"ITP382_Building9.png";
            break;
        case FLAT_GREEN:
            filename = @"ITP382_Building4.png";
            break;
        case FLAT_BLUE:
            filename = @"ITP382_Building8.png";
            break;
        case SKINNY_BRICK:
            filename = @"ITP382_Building6.png";
            break;
        case FAT_BRICK:
            filename = @"ITP382_Building10.png";
            break;
        case SKINNY_WHITE_BLUE_WINDOW:
            filename = @"ITP382_Building5.png";
            break;
        default:
            filename = @"big-building.png";
            break;
    }
    
    return [[[self alloc] initBuildingWithPhysicsProperties:properties
                                           Filename:filename] autorelease];
}

@end
