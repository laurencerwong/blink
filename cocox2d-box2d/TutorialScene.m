//
//  TutorialScene.m
//  cocox2d-box2d
//
//  Created by Laurence Wong on 10/23/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import "TutorialScene.h"

@implementation TutorialScene

-(id) initScene
{
    self = [super init];
    if (self) {
        
        touchLayer = [TutorialLayer node];
        [self addChild:touchLayer];
    }
    return self;
}
+(id) nodeWithInit
{
	// 'scene' is an autorelease object.
	return [[self alloc] initScene];
}

- (id)init
{
    self = [super init];
    if (self) {
        touchLayer = [TutorialLayer node];
        [self addChild:touchLayer];
    }
    return self;
}



- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
