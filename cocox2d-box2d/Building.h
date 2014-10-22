//
//  Building.h
//  cocox2d-box2d
//
//  Created by Keith DeRuiter on 9/30/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import "GamePhysicsObject.h"
#import "BuildingProperties.h"

@interface Building : GamePhysicsObject
{

}

+(id) nodeWithPosition:(CGPoint)position BuildingType:(BuildingType)buildingType;

@end
