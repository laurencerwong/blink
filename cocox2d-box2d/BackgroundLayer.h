//
//  BackgroundLayer.h
//  cocox2d-box2d
//
//  Created by Kristine Brown on 9/21/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import "cocos2d.h"
#import "BackgroundSprite.h"

@interface BackgroundLayer : CCLayerColor
{
    CCSprite *trees;
    float playerXPosition_;
    NSMutableArray *backgroundSprites;
    NSMutableArray *invisibleBackgroundSprites;
    NSMutableArray *visibleBackgroundSprites;
    BackgroundSprite *furthestBackgroundSprite;
    float combinedBackgroundWidth;
}

@property float playerXPosition;

-(void) update:(ccTime)delta;
@end
