//
//  LevelSelectScene.h
//  cocox2d-box2d
//
//  Created by Laurence Wong on 10/22/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import "cocos2d.h"
#import "CCScene.h"

@interface LevelSelectScene : CCScene
{
    CCSprite *background;
    UIScrollView *content_;
    CCMenuItem *backButton;
    CCMenu *levelMenu;
}

-(UIScrollView *) getContent;
+(CCScene*) scene;
-(id) initWithLevels:(NSArray *)levels;
@end
