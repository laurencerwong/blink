//
//  BackgroundLayer.m
//  cocox2d-box2d
//
//  Created by Kristine Brown on 9/21/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import "BackgroundLayer.h"

@implementation BackgroundLayer

@synthesize playerXPosition = playerXPosition_;

- (id)init
{
    if( (self=[super initWithColor: ccc4(85, 26, 139, 255)]) ){
        [self initializeBackgrounds];
    }
    return self;
}

-(void) initializeBackgrounds
{
    //TODO for performance resons, we should use a sprite cache thing for sprites
    
    //String array instead of sprite cache for now
//    NSArray *imageArray = [NSArray arrayWithObjects:@"ITP382_Building5.png", @"ITP382_Building4.png", @"ITP382_Building3.png", @"ITP382_Building2.png", @"ITP382_Building1.png", @"ITP382_Building5.png", @"ITP382_Building4.png", @"ITP382_Building3.png", nil];
    NSArray *imageArray = [NSArray arrayWithObjects:@"city_bg_1.png", @"city_bg_1.png", @"city_bg_1.png", @"city_bg_1.png", @"city_bg_1.png", @"city_bg_1.png", @"city_bg_1.png", @"city_bg_1.png", @"city_bg_1.png", @"city_bg_1.png", @"city_bg_1.png", @"city_bg_1.png", @"city_bg_1.png", @"city_bg_1.png", @"city_bg_1.png",   nil];
    
    backgroundSprites = [[NSMutableArray alloc] init];
    invisibleBackgroundSprites = [[NSMutableArray alloc] init];
    visibleBackgroundSprites = [[NSMutableArray alloc] init];
    CGSize s = [[CCDirector sharedDirector] winSize];
    
    
    //BG1
    for(NSString *string in imageArray)
    {
    BackgroundSprite *defaultBackground = [BackgroundSprite nodeWithFile:string];
    defaultBackground.position = ccp(s.width/2,s.height/2);
    //defaultBackground.rotation = 90;
    defaultBackground.visible = NO;
    [backgroundSprites addObject:defaultBackground];
    [invisibleBackgroundSprites addObject:defaultBackground];
    //combinedBackgroundWidth += defaultBackground.contentSize.width;
    }
    
    for(BackgroundSprite *sprite in backgroundSprites) {
        [self addChild:sprite];
    }
    
    while(combinedBackgroundWidth < s.width)
    {
        [self pickNewBackground];
    }
}

-(void) pickNewBackground
{
    CGSize s = [[CCDirector sharedDirector] winSize];
    //keep reference to front of list that keeps track of background images and
    //clever math your way to figure out when to push new one to end of list
    int randomBackground = arc4random() % invisibleBackgroundSprites.count;
    BackgroundSprite *tempBackground = [invisibleBackgroundSprites objectAtIndex:randomBackground];
    if(visibleBackgroundSprites.count == 0)
    {
        tempBackground.position = ccp(0, s.height/2);
        tempBackground.visible = YES;
    }
    else
    {
        BackgroundSprite *lastBackground = [visibleBackgroundSprites objectAtIndex: visibleBackgroundSprites.count - 1];
        tempBackground.position = ccp(lastBackground.position.x + lastBackground.contentSize.width/2 + tempBackground.contentSize.width/2, s.height/2);
        tempBackground.visible = YES;
    }
    [visibleBackgroundSprites addObject:tempBackground];
    [invisibleBackgroundSprites removeObject:tempBackground];
    combinedBackgroundWidth += tempBackground.contentSize.width;
}

-(void) update:(ccTime)delta
{
    CGSize s = [[CCDirector sharedDirector] winSize];

    //We only need to worry about the background to the furthest left
    BackgroundSprite *background = [visibleBackgroundSprites objectAtIndex:0];

    
    //Check if background is off the screen
    if(background.position.x +  self.position.x - background.contentSize.width/2 < background.contentSize.width * -1)
    {
        //background.position = ccp(self.position.x * -1 + s.width/2, s.height/2);
        background.visible = NO;
        [invisibleBackgroundSprites addObject:background];
        [visibleBackgroundSprites removeObject:background];
        combinedBackgroundWidth -= background.contentSize.width;
        background = [visibleBackgroundSprites objectAtIndex:0];
    }
    //Check if we need to add a new background
    if(background.position.x + combinedBackgroundWidth + self.position.x - s.width < s.width)
    {
        [self pickNewBackground];
    }
    //place sprites to view BG
}

-(void) dealloc
{
    [backgroundSprites dealloc];
    [super dealloc];
}

@end
