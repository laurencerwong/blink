//
//  CameraDummyObject.m
//  cocox2d-box2d
//
//  Created by Student on 10/5/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import "CameraDummyObject.h"

@implementation CameraDummyObject

@synthesize currentPlayerPosition = currentPlayerPosition_;

- (id)init
{
    self = [super init];
    if (self) {
        CGSize s = [[CCDirector sharedDirector]winSize];
        //100 is the player distance from the left side of the screen
        playerDistanceFromSideOfScreen = s.width/2 - 50;
        pConstant = 1.337 + .2;
        dConstant = 8.0085;
        
        self.position = ccp(0, s.height/2);
    }
    return self;
}

-(void) update:(ccTime)delta
{
    //deltaPosition = constant * (Where i want to be - where i am)
    lastDelta = currentDelta;
    currentDelta = (self.currentPlayerPosition + playerDistanceFromSideOfScreen - self.position.x);

    float deltaPosition = pConstant * currentDelta;
    
    deltaPosition += dConstant * (lastDelta - currentDelta);
    
    self.position = ccpAdd(self.position, ccp(deltaPosition * delta, 0));
}
@end
