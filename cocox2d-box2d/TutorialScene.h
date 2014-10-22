//
//  TutorialScene.h
//  cocox2d-box2d
//
//  Created by Laurence Wong on 10/23/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import "CCScene.h"
#import "TutorialLayer.h"

@interface TutorialScene : CCScene
{
    UITouch *heroTouch;
    TutorialLayer *touchLayer;
    CGPoint dragLocation;
}

+(id) nodeWithInit;

@end
