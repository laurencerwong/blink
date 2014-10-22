//
//  UILayer.m
//
//  Created by Laurence Wong on 9/10/13.
//
//

#import "UILayer.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation UILayer


-(id)init
{
    self = [super init];
    if(self)
    {
        CGSize size = [[CCDirector sharedDirector] winSize];
    
        
        //Make energy label
        /*blinkEnergy = [CCLabelTTF labelWithString:@"Energy: 1000"
                                         fontName:@"AppleGothic"
                                         fontSize:20
                                       dimensions:CGSizeMake(200, 25)
                                       hAlignment:kCCTextAlignmentLeft];
        
        if(size.width > size.height)
        {
            blinkEnergy.position = ccp(105, size.height - 15);
        }
        else
        {
            blinkEnergy.position = ccp(size.height - 15, 105);
        }
        blinkEnergy.visible = YES;
        [self addChild: blinkEnergy];*/
        
        
        //Make level over label
        levelOver = [CCLabelTTF labelWithString:@"YOU WIN" fontName:@"Marker Felt" fontSize:30];
        levelOver.position = ccp(size.width/2, size.height/2);
        levelOver.visible = NO;
        [self addChild: levelOver];
        
        //make powerbarBox
        powerBarBox = [CCSprite spriteWithFile:@"powerbarboxbig.png"];
        powerBarBox.position = ccp(powerBarBox.contentSize.width/2, size.height - powerBarBox.contentSize.height / 2 - 10);
        powerBarBox.visible = YES;
        [self addChild:powerBarBox z:1];
        
        //make powerBar
        powerBar = [CCProgressTimer progressWithSprite:[CCSprite spriteWithFile:@"powerbarenergybig.png"]];
        powerBar.type = kCCProgressTimerTypeBar;
        powerBar.position = powerBarBox.position;
        powerBar.visible = YES;
        powerBar.percentage = 100;
        powerBar.barChangeRate = ccp(1, 0);
        powerBar.midpoint = ccp(-1, 0);
        [self addChild: powerBar];
        
        //Make level over label
        countDownToStart = [CCLabelTTF labelWithString:@"READY" fontName:@"Marker Felt" fontSize:50];
        countDownToStart.position = ccp(size.width/2, size.height/2);
        countDownToStart.visible = NO;
        [self addChild: countDownToStart];
    }
    return self;
}

-(void)updateBlinkEnergy:(int)num
{
    blinkEnergy.string = [NSString stringWithFormat:@"Energy: %d", num];
}

-(void)hideLevelOverSuccess
{
    levelOver.visible = NO;
}


-(void)showLevelOverSuccess
{
    levelOver.string = [NSString stringWithFormat:@"YOU WIN"];
    levelOver.visible = YES;
}

-(void)hideLevelOverFailure
{
    levelOver.visible = NO;
}


-(void)showLevelOverFailure
{
    levelOver.string = [NSString stringWithFormat:@"YOU LOSE"];
    levelOver.visible = YES;
}

-(void)setPowerBarPercentage:(float)percentage
{
    powerBar.percentage = percentage * 100.0f;
}

-(void) hideCountDownToStart
{
    countDownToStart.visible = NO;
}

-(void) showCountDownToStart:(int)curCountDownNum
{
    countDownToStart.visible = YES;
    countDownToStart.string = curCountDownNum == 2 ? [NSString stringWithFormat:@"READY"] : [NSString stringWithFormat:@"GO"];

}

@end
