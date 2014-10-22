//
//  TutorialLayer.m
//  cocox2d-box2d
//
//  Created by Laurence Wong on 10/23/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import "TutorialLayer.h"
#import "MainMenuLayer.h"

@implementation TutorialLayer

- (id)init
{
    self = [super init];
    if (self) {
        self.touchEnabled = YES;
        s = [[CCDirector sharedDirector] winSize];
        tutorialSprites = [[NSMutableArray alloc] init];
        CCSprite *image1 = [CCSprite spriteWithFile:@"TeleportTutorial.png"];
        image1.position = ccp(s.width/2, s.height/2);
        CCSprite *image2 = [CCSprite spriteWithFile:@"JumpTutorial.png"];
        image2.position = ccp(s.width/2, s.height/2);
        CCSprite *image3 = [CCSprite spriteWithFile:@"ObjectiveTutorial.png"];
        image3.position = ccp(s.width/2, s.height/2);
        [tutorialSprites addObject:image3];
        [tutorialSprites addObject:image2];
        [tutorialSprites addObject:image1];
        image1.visible = NO;
        image2.visible = NO;
        image3.visible = YES;
        tutorialIndex = 0;
        [self addChild:image3];
        [self addChild:image2];
        [self addChild:image1];
    }
    return self;
}
-(void) onEnter
{
    [[[CCDirector sharedDirector ]touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}
-(void) onExit
{
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate: self];
}
-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint location = [self convertTouchToNodeSpace: touch];
    dragLocation = location;
    heroTouch = touch;
    
    return YES;
}

-(BOOL) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    dragLocation =[self convertTouchToNodeSpace: touch];
    CCSprite *tempSprite = [tutorialSprites objectAtIndex:tutorialIndex];
    CGPoint spriteLocation = tempSprite.position;
    tempSprite.position = ccp(dragLocation.x, spriteLocation.y);
    return YES;
}

-(BOOL) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    if(touch == heroTouch)
    {
        heroTouch = nil;
        CGPoint spriteLocation = ((CCSprite *)[tutorialSprites objectAtIndex:tutorialIndex]).position;
        if(spriteLocation.x < s.width/4 * 3)
        {
            ((CCSprite *)[tutorialSprites objectAtIndex:tutorialIndex]).visible = NO;
            ((CCSprite *)[tutorialSprites objectAtIndex:tutorialIndex]).position = ccp(s.width/2, s.height/2);
            tutorialIndex = (tutorialIndex + 1) % 3;
            ((CCSprite *)[tutorialSprites objectAtIndex:tutorialIndex]).visible = YES;
            ((CCSprite *)[tutorialSprites objectAtIndex:tutorialIndex]).position = ccp(s.width/2, s.height/2);
        }
        else if(spriteLocation.x > s.width/4 * 3)
        {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInL transitionWithDuration:0.2 scene:[MainMenuLayer scene]]];
        }
    }
    return YES;
}

- (void)dealloc
{
    [tutorialSprites dealloc];
    [super dealloc];
}


@end
