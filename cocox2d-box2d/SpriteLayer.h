//
//  SpriteLayer.h
//  cocox2d-box2d
//
//  Created by Kristine Brown on 9/21/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"
//#import "Box2D.h"
#import "PhysicsEngine.h"
#import "GLES-Render.h"

#import "CameraDummyObject.h"
#import "Hero.h"
#import "Level.h"


//Pixel to metres ratio. Box2D uses metres as the unit for measurement.
//This ratio defines how many pixels correspond to 1 Box2D "metre"
//Box2D is optimized for objects of 1x1 metre therefore it makes sense
//to define the ratio so that your most common object type is 1x1 metre.
#define PTM_RATIO 32

@interface SpriteLayer : CCLayer
{
    Hero *hero_;
    CameraDummyObject *camera_;
    b2World *world;
    
    CCTexture2D *spriteTexture_;	// weak ref
    BOOL slowTime_;
    
    UITouch *heroTouch;
    CGPoint dragLocation;
    BOOL validBlink;
    
    Level *currentLevel;

    enum LevelStatus {
        Playing, Victory, Defeat, LevelOver
    };
    LevelStatus levelStatus_;
    
    int maxStreaks;
    NSMutableArray *streaks;
    int currentStreak;
    CCTexture2D *streakTexture;
    
    NSMutableArray *dynamicObjects; //objects that we are gonna generate and destroy on the fly
    NSMutableArray *particleSystems;
    CCParticleGalaxy *preTeleportExplosion;
    CCParticleGalaxy *postTeleportExplosion;
    CCParticleRain *rain;
    
    int nextEntityTriggerIndex;
}

@property Hero *hero;
@property CameraDummyObject *camera;
@property BOOL slowTime;
@property enum LevelStatus levelStatus;

-(void) update:(ccTime)delta;

-(void) initializeCamera;
-(void) initializeHero;
-(void) initializeEndGoal;
-(void) initializeBuildings;
-(void) initializeEntities;

-(void) registerWithTouchDispatcher;
-(BOOL) ccTouchBegan:(UITouch*)touch withEvent:(UIEvent *)event;
-(BOOL) ccTouchMoved:(UITouch*)touch withEvent:(UIEvent *)event;
-(BOOL) ccTouchEnded:(UITouch*)touch withEvent:(UIEvent *)event;

-(id) initWithFilename:(NSString *)filename;

@end
