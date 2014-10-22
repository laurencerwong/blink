//
//  LevelSelectScene.m
//  cocox2d-box2d
//
//  Created by Laurence Wong on 10/22/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import "LevelSelectScene.h"
#import "MainMenuLayer.h"
#import "GameplayScene.h"
#import "LevelSelectSprite.h"

@implementation LevelSelectScene

-(UIScrollView *)getContent
{
    return content_;
}


-(void) startLevel:(LevelSelectSprite *)sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameplayScene nodeWithFile:sender.levelName]]];
}

-(id) initWithLevels:(NSArray *)levels
{
    self = [super init];
    if (self) {
        CGSize s = [[CCDirector sharedDirector] winSize];
        background = [CCSprite spriteWithFile:@"Level_Select_Background.png"];
        background.position = ccp(s.width/2, s.height/2);
        [self addChild:background z:0];
        backButton = [CCMenuItemImage itemWithNormalImage:@"backbutton.png" selectedImage:@"backbutton.png" target:self selector:@selector(exitScene)];
        backButton.anchorPoint = ccp(0, 1);
        backButton.position = ccp(10, s.height - 15);
        //[self addChild:backButton z:1];
        //levelMenu = [CCMenu menuWithItems: nil];
        NSMutableArray *items = [[[NSMutableArray alloc] init]autorelease];
        //[levelMenu addChild:backButton];
        int levelCount = 0;
        int row = 0;
        int col = 0;
        while(levelCount < [levels count])
        {
            LevelSelectSprite *levelSprite = [LevelSelectSprite nodeWithlevelName:[levels objectAtIndex:levelCount] LevelNum:levelCount + 1 Target:self Selector:@selector(startLevel:)];
            levelSprite.anchorPoint = ccp(1,1);
            levelSprite.position = ccp(col * 85 + 100, s.height - (row * 85) - 15);
            //[levelMenu addChild:levelSprite];
            row = (++levelCount)/5;
            col = levelCount%5;
            [items addObject:levelSprite];
        }
        levelMenu = [CCMenu menuWithArray:items];
        [levelMenu addChild:backButton];
        levelMenu.position = ccp(0, 0);
        //levelMenu.anchorPoint = ccp(1,1);

        levelMenu.position = ccp(0, 0);
        CGRect scrollViewSize = CGRectMake(levelMenu.position.x, levelMenu.position.y, levelMenu.contentSize.width, levelMenu.contentSize.height);
        content_ = [[UIScrollView alloc] initWithFrame:scrollViewSize];
        [self addChild:levelMenu z:1];
    }
    return self;
}


-(void) exitScene
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInL transitionWithDuration:0.2 scene:[MainMenuLayer scene]]];
}

+(CCScene*) scene
{
    //return [self node];
    NSArray *inLevels = [NSArray arrayWithObjects:@"level1.json", @"level2.json", @"level3.json", @"level4.json", @"level5.json", @"level6.json", @"level.json" , nil];
    //populate inLevels
    return [[self alloc] initWithLevels:inLevels];
}
@end
