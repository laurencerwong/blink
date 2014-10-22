//
//  Hero.h
//  cocox2d-box2d
//
//  Created by Kristine Brown on 9/21/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"
//#import "Box2D.h"
#import "PhysicsEngine.h"
#import "GamePhysicsObject.h"
#import "RaycastCallback.h"

typedef enum HeroState : NSInteger{
    ALIVE,
    DEAD,
    JUMPING,
    BLINKING
} HeroState;

typedef enum CollisionDirection : NSInteger{
    TOP,
    RIGHT,
    DOWN,
    LEFT
} CollisionDirection;

@interface Hero : GamePhysicsObject
{
    float desiredVelocity;
    float jumpImpulse;
    float airborneTime;
    int remainingBlinkEnergy_;
    int maxBlinkEnergy_;
    float energyRechargeSpeed;
    bool needsToUpdateBlinkEnergy_;
    BOOL canJump;
    BOOL hasJumpedRecently;
    BOOL startMoving;
    BOOL hasShield;
    BOOL hasInfiniteEnergy;
    CCSprite *shield;
    HeroState state_;
    int shieldStatus;
    int maxShieldStatus_;
    CCParticleSystem *preTeleportExplosion;
    CCParticleSystem *postTeleportExplosion;
    CCParticleSmoke *trailingTeleportParticles;
}

@property int remainingBlinkEnergy;
@property int maxBlinkEnergy;
@property bool needsToUpdateBlinkEnergy;
@property HeroState state;


+(id) nodeWithPosition:(CGPoint)position;
-(void) update:(ccTime)delta;
-(void) setupAnim;
-(void) jump;
-(void) blinkToPosition:(CGPoint)position;
-(void) startParticleTrail;
-(void) stopParticleTrail;
-(void) setPreTeleportExplosion:(CCParticleSystem *)explosion;
-(void) setPostTeleportExplosion:(CCParticleSystem *)explosion;
-(void) setTrailingTeleportParticles:(CCParticleSmoke *)smoke;
-(CCParticleSmoke *) getTrailingTeleportParticles;
-(void) preTeleportExplosion;
-(void) postTeleportExplosion;

-(void) die;
-(void) startMoving;

@end
