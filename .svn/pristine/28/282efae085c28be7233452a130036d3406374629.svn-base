//
//  GameplayScene.h
//  cocox2d-box2d
//
//  Created by Keith DeRuiter on 9/22/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import "CCScene.h"
#import "BackgroundLayer.h"
#import "SpriteLayer.h"
#import "UILayer.h"
#import "PhysicsEngine.h"

@interface GameplayScene : CCScene
{
    BackgroundLayer* backgroundLayer;
    SpriteLayer* spriteLayer;
    UILayer* uiLayer;

    b2World* world;					// strong ref
    GLESDebugDraw *m_debugDraw;		// strong ref
    char countDownNum; //The number to count down from before starting the game

}

-(void) update:(ccTime)delta;
-(id) initWithFilename:(NSString *)filename;
+(CCScene*) scene;
+(id) nodeWithFile:(NSString *)filename;

@end
