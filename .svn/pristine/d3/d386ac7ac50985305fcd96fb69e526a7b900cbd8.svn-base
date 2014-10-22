//
//  TutorialLayer.h
//  cocox2d-box2d
//
//  Created by Laurence Wong on 10/23/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import "cocos2d.h"

@interface TutorialLayer : CCLayer
{
    CGSize s;
    UITouch *heroTouch;
    CGPoint dragLocation;
    int tutorialIndex;
    NSMutableArray *tutorialSprites;
}
-(void)onEnter;
-(void)onExit;
-(BOOL) ccTouchBegan:(UITouch*)touch withEvent:(UIEvent *)event;
-(BOOL) ccTouchMoved:(UITouch*)touch withEvent:(UIEvent *)event;
-(BOOL) ccTouchEnded:(UITouch*)touch withEvent:(UIEvent *)event;
@end
