//
//  SpriteLayer.m
//  cocox2d-box2d
//
//  Created by Kristine Brown on 9/21/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import "SpriteLayer.h"
#import "GameplayScene.h"
#import "RaycastCallback.h"
#import "Spiky.h"
#import "Building.h"
#import "Meteor.h"
#import "PowerUp.h"
#import "Missile.h"
#import "EntityTriggerProperties.h"
#import "SimpleAudioEngine.h"

@implementation SpriteLayer

@synthesize camera = camera_;
@synthesize hero = hero_;
@synthesize slowTime = slowTime_;
@synthesize levelStatus = levelStatus_;

enum {
	kTagParentNode = 1,
};

- (id)initWithFilename:(NSString *)filename
{
    self = [super init];
    if (self) {
        //Enable touch
        self.touchEnabled = YES;
        
        //Set up sprite cache
        //[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BlinkSpriteSheet.plist"];
        
        //Streak stuff
        maxStreaks = 4;
        streaks = [[NSMutableArray alloc] init];
        ccColor3B color;
        color.r = 255;
        color.g = 255;
        color.b = 255;
        streakTexture = [[CCTextureCache sharedTextureCache] addImage:@"blinkStreak.png"];
        
        for(int i = 0; i < maxStreaks; i++)
        {
            CCMotionStreak *streak;
            streak = [CCMotionStreak streakWithFade:1.5 minSeg:1 width:32 color:color texture:streakTexture];
            [streaks addObject:streak];
            [self addChild:streak];
        }
        
        //Load level file
        NSString *resDir = [[NSBundle mainBundle] resourcePath];
        currentLevel = [[Level alloc] initFromJSON:[resDir stringByAppendingPathComponent: filename]];
        self.levelStatus = Playing;
        
        dynamicObjects = [[NSMutableArray alloc] init];
        particleSystems = [[NSMutableArray alloc]init];
        for(int i = 0; i < 12; ++i)
        {
            //need persistent particle systems so that particles don't
            //disappear when the objects generating them are destroyed
            CCParticleSmoke *newSmoke = [CCParticleSmoke node];
            [self addChild:newSmoke];
            [newSmoke stopSystem];
            [particleSystems addObject:newSmoke];
        }
        rain = [CCParticleRain node];
        [self addChild:rain];
        //[rain stopSystem];
        [self initializeRain];
    }
    return self;
}

-(void) initializeRain
{
    rain.position = ccp(self.camera.position.x, self.contentSize.height + 50);
    [rain resetSystem];
    [rain setDuration:-1];
    rain.texture = [[CCTextureCache sharedTextureCache] addImage:@"raindrop.png"];
    rain.positionType = kCCPositionTypeRelative;
    rain.gravity = ccp(0, -1000);
    rain.totalParticles = 250;
    rain.startSize = 15;
    rain.emissionRate = 50.0;
}

-(void) update:(ccTime)delta
{    
    CGSize s = [[CCDirector sharedDirector] winSize];
    [self.hero update:delta];
    self.camera.currentPlayerPosition = self.hero.position.x;
    rain.position = ccp(self.camera.position.x, self.contentSize.height + 200);
    
    [self.camera update:delta];
    
    if(self.levelStatus == Playing) {
        if(self.hero.position.x >= currentLevel.length)
        {
            self.levelStatus = Victory;
        }
        else if (self.hero.state == DEAD)
        {
            self.levelStatus = Defeat;
        }
    }
    
    //Check entity triggers
    if(nextEntityTriggerIndex < [currentLevel.entityTriggers count])
    {
        EntityTriggerProperties *currentTrigger = [currentLevel.entityTriggers objectAtIndex:nextEntityTriggerIndex];
        if(self.hero.position.x > currentTrigger.xTrigger)
        {
            [self addEntityType:currentTrigger.entityType AtPosition:currentTrigger.entityPosition];
            nextEntityTriggerIndex++;
        }
    }
    
    //Update blink coloring
    if(heroTouch)
    {
        validBlink = YES;
        //Raycasting stuff
        
        RayCastCallback callback;
        
        //Need to divide by PTM_RATIO to convert from pixels to box2d units
        const b2Vec2 b2_heroLocation = b2Vec2(self.hero.position.x / PTM_RATIO, self.hero.position.y / PTM_RATIO);
        const b2Vec2 b2_dragLocation = b2Vec2((dragLocation.x - self.position.x) / PTM_RATIO, (dragLocation.y - self.position.y) / PTM_RATIO);
        
        [PhysicsEngine Engine]->world->RayCast(&callback, b2_heroLocation, b2_dragLocation);
        
        if(callback.fixture_)
        {
            //Add conditional code here to check if you can blink through this part
            validBlink = NO;
        }
        
        //reset slowtime
        [self unschedule:@selector(stopSlowTime)];
    }
    
    //Iterate through dynamic objects and remove the ones that we don't need anymore
    NSMutableIndexSet *itemsToDestroy = [NSMutableIndexSet indexSet];
    int index = 0;
    for(GamePhysicsObject *gpo in dynamicObjects)
    {
        if([gpo destroyMe] || [gpo position].x + [gpo contentSize].width/2 < self.camera.position.x - s.width/2)
        {
            [self removeChild:gpo];
            [itemsToDestroy addIndex:index];
            if(gpo.objectType == METEOR)
            {
                [[(Meteor*)gpo getParticleSystem] stopSystem];
                [particleSystems addObject:[(Meteor*)gpo getParticleSystem]];
                [self makeExplosionAtPosition:gpo.position];
            }
            if(gpo.objectType == MISSILE)
            {
                [[(Missile*)gpo getParticleSystem] stopSystem];
                [particleSystems addObject:[(Missile*)gpo getParticleSystem]];
            }
        }
        ++index;
    }
    [dynamicObjects removeObjectsAtIndexes:itemsToDestroy];
}

-(void) makeExplosionAtPosition:(CGPoint)position
{
    CCParticleExplosion *newFireworks = [CCParticleExplosion node];
    [newFireworks setPosition:position];
    [newFireworks setDuration:0.4];
    [newFireworks setLife:1.0];
    [newFireworks setLifeVar:0.3];
    [newFireworks setTotalParticles:50];
    [newFireworks setSpeed:100];
    [newFireworks setStartSize:100];
    [newFireworks setEndSize:0];
    [newFireworks setStartColor:ccc4f(1.0, 0.8, 0.0, 1.0)];
    [newFireworks setStartColorVar:ccc4f(0.2, 0.0, 0.0, 0.0)];
    [newFireworks setEndColor:ccc4f(0.0f, 0.0f, 0.0f, 1.0f)];
    [newFireworks setEndColorVar:ccc4f(0.0f, 0.0f, 0.0f, 0.0f)];
    [newFireworks setAngleVar:90];
    [newFireworks setSpeedVar:200];
    [newFireworks setPositionType: kCCPositionTypeRelative];
    newFireworks.autoRemoveOnFinish = YES;
    [self addChild:newFireworks];
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"explosion.wav"];
}


-(void) addBuildingType:(BuildingType) type AtPosition:(CGPoint) position
{
    NSLog(@"Adding building at position: (%f, %f)", position.x, position.y);
    Building *building = [Building nodeWithPosition:position BuildingType:type];
    [self addChild:building];
}

-(void) initializeCamera
{
    CGSize s = [[CCDirector sharedDirector] winSize];
    self.camera = [CameraDummyObject node];
    self.camera.position = ccp(0,s.height/2);
    [self addChild: self.camera];
}

-(void) initializeHero
{
    //self.hero = [Hero nodeWithPosition: ccp(s.width/4, s.height/2 + 100)];
    preTeleportExplosion = [CCParticleGalaxy node];
    postTeleportExplosion = [CCParticleGalaxy node];
    [self addChild:preTeleportExplosion];
    [self addChild:postTeleportExplosion];
    self.hero = [Hero nodeWithPosition: ccp(currentLevel.playerStartLocation.x, currentLevel.playerStartLocation.y)];
    [self.hero setupAnim];
    
    NSLog(@"Hero initializd at position (%f, %f)", self.hero.position.x, self.hero.position.y);
    [self addChild: self.hero];
    [self.hero setTrailingTeleportParticles:[particleSystems objectAtIndex:0]];
    [particleSystems removeObjectAtIndex:0];
    
    [self.hero setPreTeleportExplosion:preTeleportExplosion];
    [self.hero setPostTeleportExplosion:postTeleportExplosion];
    [preTeleportExplosion stopSystem];
    [postTeleportExplosion stopSystem];
}

-(void) initializeBuildings
{
    NSArray *buildings = currentLevel.buildings;
    NSLog(@"Initializing Buildings... numBldgs: %d", buildings.count);
    for(BuildingProperties *val in buildings)
    {
        //        CGPoint buildingPosition = CGPointMake([val CGPointValue].x, [val CGPointValue].y);
        [self addBuildingType:val.buildingType AtPosition:val.buildingPosition];
    }
}

-(void) addEntityType:(EntityType) type AtPosition:(CGPoint) position
{
    NSLog(@"Adding entity at position: (%f, %f)", position.x, position.y);
    switch(type)
    {
        case SPIKY_ENTITY:
        {
            Spiky *newSpiky = [Spiky nodeWithPosition:position];
            [self addChild:newSpiky];
            break;
        }
        case SHIELDPWRUP_ENTITY:
        case INFINITPWRUP_ENTITY:
        {
            PowerUp *newPowerUp = [PowerUp nodeWithPosition:position PowerUpType:type];
            [self addChild:newPowerUp];
            [dynamicObjects addObject:newPowerUp];
            break;
        }
        case MISSILE_ENTITY:
            [self addMissileAtPosition:position];
            break;
        case METEOR_ENTITY:
            [self addMeteorWithTarget:position];
            break;
        default:
        {
            break;
        }
    }
}

-(void) addMissileAtPosition:(CGPoint)position
{
    if([particleSystems count] == 0)
    {
        NSLog(@"Ran out of particle systems");
        return;
    }
    CGSize s = [[CCDirector sharedDirector] winSize];
    //Missile* newMissile = [Missile nodeWithPosition: ccp(self.camera.position.x + s.width/2 + 50, 300)];
    Missile *newMissile = [Missile nodeWithPosition:position];
    [self addChild:newMissile];
    [newMissile setParticleSystem:[particleSystems objectAtIndex:0]];
    [dynamicObjects addObject:newMissile];
    [particleSystems removeObjectAtIndex:0];
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"explosion.wav"];
}

-(void) addMeteorWithTarget:(CGPoint)target
{
    NSLog(@"Adding Meteor");
    if([particleSystems count] == 0)
    {
        NSLog(@"Ran out of particle systems");
        return;
    }
    //Meteor* newMeteor = [Meteor nodeWithPosition:ccpAdd(self.hero.position, ccp(0, 200)) AndTargetPosition:ccpAdd(self.hero.position, ccp(100, 0)) WithSpeed:15.0];
    Meteor* newMeteor = [Meteor nodeWithPosition:ccpAdd(target, ccp(0, 400))
                                  TargetPosition:target
                                           Speed:15.0];
    [self addChild:newMeteor];
    [dynamicObjects addObject: newMeteor];
    [newMeteor setParticleSystem:[particleSystems objectAtIndex:0]];
    [particleSystems removeObjectAtIndex:0]; //treating the nsmutablearray like a linked list
}

-(void) initializeEntities
{
    NSArray *entities = currentLevel.entities;
    NSLog(@"Initializing entieies... numEntities: %d", entities.count);
    for(EntityProperties *val in entities)
    {
        [self addEntityType:val.entityType AtPosition:val.entityPosition];
    }
}

-(void) initializeEndGoal
{
    EndGoal *goal = [EndGoal nodeWithPosition:ccp(currentLevel.length, 150)];
    [self addChild:goal];
    NSLog(@"End Goal Initialized");
}

-(void) registerWithTouchDispatcher {
    [[CCDirector sharedDirector].touchDispatcher addTargetedDelegate:self priority:INT_MIN+1 swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    //[self addMissile];
    //[self addMeteor];
    self.slowTime = false;
    CGPoint location = [self convertTouchToNodeSpace: touch];
    CGPoint screenSpaceLocation = ccp(location.x + self.position.x, location.y);
    dragLocation = screenSpaceLocation;
    
    NSLog(@"box: %f, %f scrSpLoc: %f, %f", self.hero.boundingBox.origin.x, self.hero.boundingBox.origin.y, screenSpaceLocation.x, screenSpaceLocation.y);
    
    CGRect heroBoundingBox = self.hero.boundingBox;
    CGRect largeHeroBoundingBox = CGRectMake(
                                             heroBoundingBox.origin.x - heroBoundingBox.size.width/1.5,
                                             heroBoundingBox.origin.y - heroBoundingBox.size.height/1.5,
                                             3 * heroBoundingBox.size.width,
                                             3 * heroBoundingBox.size.height);
    
    if(CGRectContainsPoint(largeHeroBoundingBox, location))
    {
        heroTouch = touch;
        self.slowTime = YES;
        
        currentStreak = (currentStreak + 1) % maxStreaks;
        //   CCMotionStreak *streak = [streaks objectAtIndex:currentStreak];
        //[streak reset];
        
        //[streak setPosition:self.hero.position];
        
        [self.hero startParticleTrail];
    }
    else
    {
        [self.hero jump];
    }
    
    return YES;
}

-(BOOL) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint location = [self convertTouchToNodeSpace: touch];
    dragLocation = ccpAdd(location, self.position);
    
    
    return YES;
}

-(BOOL) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"Hero Postion: (%f, %f) dragLocation: (%f, %f)", self.hero.position.x, self.hero.position.y, dragLocation.x, dragLocation.y);
    
    if(touch == heroTouch)
    {
        [self.hero stopParticleTrail];
        heroTouch = nil;
        if(validBlink)
        {
            [self.hero preTeleportExplosion];
            
            [self scheduleOnce:@selector(stopSlowTime) delay:.25f];
            [self.hero blinkToPosition:ccpSub(dragLocation, self.position)];
            //           CCMotionStreak *streak = [streaks objectAtIndex:currentStreak];
            //            [streak setPosition:self.hero.position];
            [self.hero postTeleportExplosion];
            
        }
        else
        {
            //          CCMotionStreak *streak = [streaks objectAtIndex:currentStreak];
            //         [streak reset];
            self.slowTime = NO;
        }
    }
    return YES;
}

-(void) stopSlowTime
{
    self.slowTime = NO;
}

-(void) draw
{
    [super draw];
    
    if(heroTouch != nil)
    {
        
        if(!validBlink)
        {
            ccDrawColor4B(255, 0, 0, 150);
        }
        else
        {
            ccDrawColor4B(0, 255, 0, 150);
        }
        glLineWidth(4.0f);
        ccDrawCircle(self.hero.position, (float)sqrt(self.hero.remainingBlinkEnergy * 100.0), CC_DEGREES_TO_RADIANS(360), 64, NO);
        ccDrawLine(self.hero.position, ccpSub(dragLocation, self.position));
    }
}

- (void)dealloc
{
    [currentLevel dealloc];
    [particleSystems dealloc];
    [dynamicObjects dealloc];
    [streaks dealloc];
    [super dealloc];
    NSLog(@"dealloc");
}

@end
