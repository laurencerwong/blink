//
//  GameplayScene.m
//  cocox2d-box2d
//
//  Created by Keith DeRuiter on 9/22/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import "GameplayScene.h"
#import "MainMenuLayer.h"
#import "SimpleAudioEngine.h"

@implementation GameplayScene
- (id)initWithFilename:(NSString *)filename
{
    self = [super init];
    if (self) {
        [[PhysicsEngine Engine] initPhysics];
        
        backgroundLayer = [BackgroundLayer node];
        [self addChild:backgroundLayer z:0];
        spriteLayer = [[[SpriteLayer alloc] initWithFilename:filename]autorelease];
        [spriteLayer initializeHero];
        [spriteLayer initializeBuildings];
        [spriteLayer initializeEntities];
        [spriteLayer initializeEndGoal];
        [spriteLayer initializeCamera];
        [self addChild:spriteLayer z:2];
        
        uiLayer = [UILayer node];
        [self addChild:uiLayer z:3];
        
        //Follow hero
        // Let the layer follow the player sprite, while restricting the scrolling to within the world size.
        // This is really all you need to do. But it's really all you *can* do either without modifying CCFollow's code.
        //CGRect worldBoundary = CGRectMake(0, 0, 20 * s.width, s.height);
        //[spriteLayer runAction:[CCFollow actionWithTarget:spriteLayer.camera worldBoundary:worldBoundary]];
        [spriteLayer runAction:[CCFollow actionWithTarget:spriteLayer.camera]];
        [backgroundLayer runAction:[CCFollow actionWithTarget:spriteLayer.camera]];
        [self scheduleUpdate];
        
        countDownNum = 2;
        [self schedule:@selector(countDown) interval:1.0f repeat:countDownNum delay:1.0f];
        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"The_Phrygian_Building_Runner.mp3"
                                                         loop:YES];
    }
    return self;
}

-(void) countDown
{
    if(countDownNum <= 0)
    {
        [uiLayer hideCountDownToStart];
        [[spriteLayer hero] startMoving];
        [self unschedule:@selector(countDown)];
    }
    else
    {
        [uiLayer showCountDownToStart:countDownNum--];
    }
    
}

-(void) update:(ccTime)delta
{
    //get player offset and pass offset to BG layer
    delta = spriteLayer.slowTime ? delta/4 : delta;
    backgroundLayer.playerXPosition = spriteLayer.hero.position.x;
    
    [backgroundLayer update:delta];
    [spriteLayer update:delta];
    
    if(spriteLayer.levelStatus == Victory)
    {
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Blink_Victory.mp3"
                                                         loop:NO];
        [uiLayer showLevelOverSuccess];
        spriteLayer.levelStatus = LevelOver;
        [self scheduleOnce:@selector(exitScene) delay:3.0];
    }
    else if (spriteLayer.levelStatus == Defeat)
    {
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        
        [uiLayer showLevelOverFailure];
        spriteLayer.levelStatus = LevelOver;
        [self scheduleOnce:@selector(exitScene) delay:3.0];
    }
    [uiLayer setPowerBarPercentage:spriteLayer.hero.remainingBlinkEnergy / 1000.0];
    spriteLayer.hero.needsToUpdateBlinkEnergy = NO;
    
    [[PhysicsEngine Engine] update:delta];
}

-(void) exitScene
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:5.0 scene:[MainMenuLayer scene]]];
}


+(id)nodeWithFile:(NSString *)filename
{
    return [[[self alloc] initWithFilename:filename] autorelease];
}

+(CCScene*) scene
{
    return [self node];
}

@end
