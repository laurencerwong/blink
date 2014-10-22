//
//  UILayer.h
//
//  Created by Laurence Wong on 9/10/13.
//
//


#import "CCLayer.h"
#import "cocos2d.h"
#import "CCLabelTTF.h"


@interface UILayer : CCLayer
{
    CCLabelTTF* blinkEnergy;
    CCLabelTTF* levelOver;
    CCLabelTTF* countDownToStart;
    CCSprite* powerBarBox;
    CCProgressTimer* powerBar;
}

-(void) updateBlinkEnergy:(int)num;

-(void) hideLevelOverSuccess;
-(void) showLevelOverSuccess;

-(void) hideLevelOverFailure;
-(void) showLevelOverFailure;

-(void) hideCountDownToStart;
-(void) showCountDownToStart:(int)curCountDownNum;

-(void) setPowerBarPercentage:(float)percentage;

@end
