//
//  Hero.m
//  cocox2d-box2d
//
//  Created by Kristine Brown on 9/21/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import "Hero.h"
#import "SimpleAudioEngine.h"

@implementation Hero

@synthesize remainingBlinkEnergy = remainingBlinkEnergy_;
@synthesize maxBlinkEnergy = maxBlinkEnergy_;
@synthesize needsToUpdateBlinkEnergy = needsToUpdateBlinkEnergy_;
@synthesize state = state_;

-(id) initHeroWithPhysicsProperties:(PhysicsObjectProperties *)properties
                           Filename:(NSString*)filename
{
    self = [super initWithPhysicsProperties:properties Filename:filename];
    if(self)
    {
        //Set up sprite cache
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"blinkEntitySprites.plist"];
        CCSpriteFrameCache *c = [CCSpriteFrameCache sharedSpriteFrameCache];
        maxShieldStatus_ = 2;
        self.remainingBlinkEnergy = 1000;
        self.maxBlinkEnergy = 1000;
        desiredVelocity = 0.0;
        jumpImpulse = 6;
        canJump = YES;
        airborneTime = 0;
        hasJumpedRecently = NO;
        state_ = ALIVE;
        self.b2Body->SetFixedRotation(true);
        shield = [[CCSprite alloc] initWithFile:@"Shield.png"];
        shield.visible = NO;
        shieldStatus = 0;
        [self addChild:shield z:10];
        shield.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        [self scheduleUpdate];
    }
    //[self scheduleOnce:@selector(startMoving) delay:2.0];
    
    return self;
}

+(id) nodeWithPosition:(CGPoint)position
{
    
    //generate properties
    PhysicsObjectProperties *properties = [[[PhysicsObjectProperties alloc] init]autorelease];
    properties.position = ccp(position.x, position.y);
    properties.type = b2_dynamicBody;
    properties.friction = .3;
    properties.mass = .1;
    properties.density = .7;
    properties.restitution = 0.0;
    properties.objectType = HERO;
    
    return [[[self alloc] initHeroWithPhysicsProperties:properties
                                               Filename:@"Walking_Hero1.png"] autorelease];
}

- (void) setupAnim
{
    NSMutableArray* files;
    if(self.state == JUMPING || self.state == BLINKING) {
        files = [NSMutableArray arrayWithObjects: @"Jump2-hd.png", nil];
    } else {
        files = [NSMutableArray arrayWithObjects: @"Running1-hd.png",
                 @"Running2-hd.png", @"Running3-hd.png", @"Running4-hd.png", nil];
    }
    
    NSMutableArray* frames = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i < files.count; i++)
    {
        NSLog(@"Making frame for: %@", [files objectAtIndex:i]);
        NSString* file = [files objectAtIndex:i];
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:file];
        [frames addObject:frame];
    }
    
    NSLog(@"Created all sprite frames");
    
    // Clear any previous actions
    [self stopAllActions];
    // Start new animation
    CCAnimation* anim = [CCAnimation animationWithSpriteFrames:frames delay:0.1f];
    CCAnimate* animate = [CCAnimate actionWithAnimation:anim];
    CCRepeatForever* repeat = [CCRepeatForever actionWithAction:animate];
    [self runAction:repeat];
}

-(CollisionDirection) checkCollisionDirection:(const CGPoint)collisionPoint
{
    //check if downward collision
    CGPoint cgCollisionPoint = ccpNormalize(ccp(collisionPoint.x, collisionPoint.y));
    float dotProduct = ccpDot(ccp(cgCollisionPoint.x, cgCollisionPoint.y), ccp(0, -1));
    float angle = acosf(dotProduct);
    if(angle > -0.3 && angle < 0.3)
    {
        return DOWN;
    }
    if(fabsf(collisionPoint.x) > collisionPoint.y)
    {
        if(collisionPoint.x > collisionPoint.y)
        {
            return RIGHT;
        }
        else
        {
            return LEFT;
        }
    }
    return TOP;
}

-(BOOL) isBuildingUnderMe
{
    RayCastCallback callback;
    
    //Need to divide by PTM_RATIO to convert from pixels to box2d units
    const b2Vec2 b2_heroLocation = b2Vec2(self.position.x / PTM_RATIO, self.position.y / PTM_RATIO);
    const b2Vec2 b2_downDirection = b2Vec2(0, 0);
    
    [PhysicsEngine Engine]->world->RayCast(&callback, b2_heroLocation, b2_downDirection);
    
    if(callback.fixture_)
    {
        return YES;
    }
    return NO;
    
}


-(void) startMoving
{
    startMoving = YES;
    desiredVelocity = 6.5;
}

-(void) update:(ccTime)delta
{
    trailingTeleportParticles.position = self.position;
    if (self.position.y < 0 - 2 * self.contentSize.height)
    {
        [self die];
        return;
    }
    if(shieldStatus > 0)
    {
        shield.visible = YES;
    }
    b2Vec2 vel = self.b2Body->GetLinearVelocity();
    
    float velChange = desiredVelocity - vel.x;
    float impulse = self.b2Body->GetMass() * velChange; //disregard time factor
    self.b2Body->ApplyLinearImpulse( b2Vec2(impulse,0), self.b2Body->GetWorldCenter() );
    
    if(self.remainingBlinkEnergy < self.maxBlinkEnergy)
    {
        self.remainingBlinkEnergy++;
    }
    b2Vec2 collisionPoint;
    NSMutableArray *collisionDetails;
    
    if([[PhysicsEngine Engine] hasCollision:self.b2Body->GetFixtureList() WithDetails:&collisionDetails] && startMoving)
    {
        for(CollisionDetail* collisionDetail in collisionDetails){
            GameObjectType type = [collisionDetail getObject].objectType;
            CollisionDirection direction = [self checkCollisionDirection:collisionDetail.pointOfCollision];
            switch(type)
            {
                case SPIKY:
                {
                    [self die];
                    break;
                }
                case MISSILE:
                case METEOR:
                {
                    [self die];
                    [collisionDetail getObject].destroyMe = YES;
                    break;
                }
                case SHLDPWRUP:
                {
                    [[SimpleAudioEngine sharedEngine] playEffect:@"shield.wav"];
                    shieldStatus = maxShieldStatus_;
                    [collisionDetail getObject].destroyMe = YES;
                    break;
                }
                case INFPWRUP:
                {
                    [[SimpleAudioEngine sharedEngine] playEffect:@"shield.wav"];
                    hasInfiniteEnergy = YES;
                    [self scheduleOnce:@selector(resetInfiniteEnergy) delay:5.0];//give them 5 seconds
                    self.remainingBlinkEnergy = self.maxBlinkEnergy;
                    [collisionDetail getObject].destroyMe = YES;
                    break;
                    
                }
                default:
                    break;
                    
            }
            if(self.state != DEAD)
            {
                switch(direction)
                {
                        
                    case RIGHT:
                        /*
                         if(airborneTime > 0.2 && type == BUILDING)
                         {
                         if(![self isBuildingUnderMe])
                         {
                         [self die];
                         }
                         //return;
                         break;
                         }
                         else
                         {
                         */
                        desiredVelocity = 0; //move them back for a second
                        //}
                        break;
                    case LEFT:
                        //i don't knoow when this should ever happen...
                        break;
                    case DOWN:
                        airborneTime = 0;
                        desiredVelocity = 6.5;
                        canJump = YES;
                        if((self.state == JUMPING && !hasJumpedRecently) || self.state == BLINKING) {
                            self.state = ALIVE;
                            [self setupAnim];
                        }
                        break;
                    case TOP:
                        //don't know what to do about this yet...
                        break;
                }
            }
        }
    }
    else
    {
        airborneTime += delta;
    }
}

-(void) resetInfiniteEnergy
{
    hasInfiniteEnergy = NO;
}

-(void) jump
{
    if(canJump)
    {
        //        [[SimpleAudioEngine sharedEngine] playEffect:@"jump.wav"];
        desiredVelocity = 6.5;
        self.state = JUMPING;
        self.b2Body->ApplyLinearImpulse(b2Vec2(0, jumpImpulse), self.b2Body->GetWorldCenter());
        canJump = NO;
        hasJumpedRecently = YES;
        
        [self scheduleOnce:@selector(resetHasJumpedRecently) delay:0.1];
        [self setupAnim];
    }
}

-(void) resetHasJumpedRecently
{
    hasJumpedRecently = NO;
}

-(void) die
{
    if(self.state == DEAD) {
        return;
    }
    if(shieldStatus > 0)
    {
        --shieldStatus;
        shield.visible = shieldStatus > 0 ? YES : NO;
        return;
    }
    self.state = DEAD;
    desiredVelocity = 0;
    [[SimpleAudioEngine sharedEngine] playEffect:@"death.wav"];
}

-(void) blinkToPosition:(CGPoint)targetPosition
{
    int distanceToTarget = ccpDistanceSQ(self.position, targetPosition);
    int blinkCost = distanceToTarget / 100;
    
    if((blinkCost <= self.remainingBlinkEnergy || hasInfiniteEnergy) && startMoving)
    {
        [[SimpleAudioEngine sharedEngine] playEffect:@"teleport.wav"];
        self.remainingBlinkEnergy -= hasInfiniteEnergy ? 0 : blinkCost;
        self.position = targetPosition;
        self.needsToUpdateBlinkEnergy = YES;

        self.state = JUMPING;
        hasJumpedRecently = YES;
        [self scheduleOnce:@selector(resetHasJumpedRecently) delay:0.1];
        
        [self setupAnim];
        desiredVelocity = 6.5;
        NSLog(@"Blunk with cost: %d, Energy remaining: %d", blinkCost, self.remainingBlinkEnergy);
    }
    else
    {
        NSLog(@"Tried to blink with cost: %d, Energy remaining: %d", blinkCost, self.remainingBlinkEnergy);
    }
}

-(void) startParticleTrail
{
    [trailingTeleportParticles resetSystem];
}


-(void) stopParticleTrail
{
    [trailingTeleportParticles stopSystem];
}

-(void) setTrailingTeleportParticles:(CCParticleSmoke *)smoke
{
    trailingTeleportParticles = smoke;
    [trailingTeleportParticles stopSystem];
    trailingTeleportParticles.texture =[[CCTextureCache sharedTextureCache] addImage:@"TeleportParticle.png"];
    trailingTeleportParticles.duration = -1;
    trailingTeleportParticles.life = 0.5;
    trailingTeleportParticles.lifeVar = 0.5;
    trailingTeleportParticles.speed = 10.0;
    trailingTeleportParticles.speedVar = 0.2;
    trailingTeleportParticles.startSize = 20.0;
    trailingTeleportParticles.endSize = 0;
    trailingTeleportParticles.positionType = kCCPositionTypeRelative;
    trailingTeleportParticles.radialAccel = 10.0;
    trailingTeleportParticles.posVar = ccp(self.contentSize.width/2, self.contentSize.height/2);
}

-(void)setPreTeleportExplosion:(CCParticleExplosion *)explosion
{
    preTeleportExplosion = explosion;
    preTeleportExplosion.texture = [[CCTextureCache sharedTextureCache] addImage:@"TeleportExplosion.png"];
    //preTeleportExplosion.emitterMode = kCCParticleModeRadius;
    //preTeleportExplosion.rotatePerSecond = 2;
    preTeleportExplosion.duration = 0.7;
    preTeleportExplosion.life = 0.7;
    preTeleportExplosion.lifeVar = 0.3;
    preTeleportExplosion.speed = 150.0;
    preTeleportExplosion.speedVar = 50;
    preTeleportExplosion.startSize = 50;
    preTeleportExplosion.endSize = 0;
    preTeleportExplosion.totalParticles = 30;
    preTeleportExplosion.startColor = ccc4f(0.1, 0.1, 0.1, 1.0);
    preTeleportExplosion.startColorVar = ccc4f(0.0, 0.0, 0.2, 0.0);
    preTeleportExplosion.endColor = ccc4f(1.0, 1.0, 1.0, 1.0);
    preTeleportExplosion.endColorVar = ccc4f(0.0, 0.0, 0.0, 0.5);
    preTeleportExplosion.positionType = kCCPositionTypeRelative;
    
}
-(void)setPostTeleportExplosion:(CCParticleExplosion *)explosion
{
    postTeleportExplosion = explosion;
    postTeleportExplosion.texture = [[CCTextureCache sharedTextureCache] addImage:@"TeleportExplosion.png"];
    postTeleportExplosion.duration = 0.7;
    //postTeleportExplosion.emitterMode = kCCParticleModeRadius;
    //postTeleportExplosion.rotatePerSecond = 2;
    postTeleportExplosion.life = 0.7;
    postTeleportExplosion.lifeVar = 0.3;
    postTeleportExplosion.speed = 150.0;
    postTeleportExplosion.speedVar = 50;
    postTeleportExplosion.startSize = 50;
    postTeleportExplosion.endSize = 0;
    postTeleportExplosion.totalParticles = 30;
    postTeleportExplosion.startColor = ccc4f(0.1, 0.1, 0.1, 1.0);
    postTeleportExplosion.startColorVar = ccc4f(0.0, 0.0, 0.2, 0.0);
    postTeleportExplosion.endColor = ccc4f(1.0, 1.0, 1.0, 1.0);
    postTeleportExplosion.endColorVar = ccc4f(0.0, 0.0, 0.0, 0.5);
    postTeleportExplosion.positionType = kCCPositionTypeRelative;
    
}

-(void)preTeleportExplosion
{
    preTeleportExplosion.position = self.position;
    [preTeleportExplosion resetSystem];
}

-(void)postTeleportExplosion
{
    postTeleportExplosion.position = self.position;
    [postTeleportExplosion resetSystem];
}

-(CCParticleSmoke *)getTrailingTeleportParticles
{
    return trailingTeleportParticles;
}

@end
