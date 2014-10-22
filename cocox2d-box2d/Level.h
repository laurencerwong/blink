//
//  Level.h
//  cocox2d-box2d
//
//  Created by Keith DeRuiter on 10/6/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EndGoal.h"

@interface Level : NSObject
{
    int length_;
    CGPoint playerStartLocation_;
    
    NSMutableArray *buildings_;
    NSMutableArray *entities_;
    NSMutableArray *entityTriggers_;
}

@property (copy) NSArray *buildings;
@property (copy) NSArray *entities;
@property (copy) NSArray *entityTriggers;
@property int length;
@property CGPoint playerStartLocation;

-(id) initFromJSON:(NSString *) filename;
-(void) initializeBuildings;

@end
