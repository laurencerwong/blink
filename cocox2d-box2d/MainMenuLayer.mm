//
//  HelloWorldLayer.m
//  duckhunt
//
//  Created by Sanjay Madhav on 8/8/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "MainMenuLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#import "GameplayScene.h"
#import "LevelSelectScene.h"
#import "TutorialScene.h"

#pragma mark - MainMenuLayer

// HelloWorldLayer implementation
@implementation MainMenuLayer

// Helper class method that creates a Scene with the MainMenuLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainMenuLayer *layer = [MainMenuLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) )
	{
		
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
		
		CCSprite *background;
		background = [CCSprite spriteWithFile:@"Main_Menu_Temp.png"];
        //		background.rotation = 90;
		
        if(size.height > size.width)
        {
            background.position = ccp(size.height/2, size.width/2);
        }
		else
        {
            background.position = ccp(size.width/2, size.height/2);
        }
		// add the image as a child to this Layer
		[self addChild: background];
		
		//
		// Leaderboards and Achievements
		//
		
		// Default font size will be 28 points.
		[CCMenuItemFont setFontSize:28];
		
		// Achievement Menu Item using blocks
		CCMenuItem *itemNewGame = [CCMenuItemFont itemWithString:@"New Game" block:^(id sender) {
			[[CCDirector sharedDirector] replaceScene :[CCTransitionFade
                                                        transitionWithDuration: 0.5
                                                        scene:[GameplayScene nodeWithFile:@"level.json"]]];
		}];
        CCMenuItem *tutorialMenuItem = [CCMenuItemFont itemWithString:@"Tutorial" block:^(id sender){
            [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:0.2 scene:[TutorialScene node]]];
        }];
        CCMenuItem *itemSelectLevel = [CCMenuItemFont itemWithString:@"Select Level" block:^(id sender){
            [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:0.2 scene:[LevelSelectScene scene]]];
        }];
		
		CCMenu *menu = [CCMenu menuWithItems:itemNewGame, tutorialMenuItem, itemSelectLevel, nil];
        
        
		[menu alignItemsVerticallyWithPadding:0];
        if(size.height > size.width)
        {
            [menu setPosition:ccp( size.height/2, size.width/2 - 100)];
        }
        else
        {
            [menu setPosition:ccp(size.width/2, size.height/2 - 100)];
        }
		
		// Add the menu to the layer
		[self addChild:menu];
        
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
