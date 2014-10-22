//
//  Missile.mm
//  cocox2d-box2d
//
//  Created by Laurence Wong on 10/19/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import "Missile.h"

@implementation Missile

-(id) initMissileWithPhysicsProperties:(PhysicsObjectProperties *)properties
                              Filename:(NSString *) filename
{
    self = [super initWithPhysicsProperties:properties Filename:filename];
    if (self) {
        speed = 1.01;
        maxSpeed = 25;
        totalDeltaTime = 0;
        [self b2Body]->SetLinearVelocity(b2Vec2(-speed, 0));
        
        [self scheduleUpdate];
        
    }
    return self;
}
-(CCParticleSystem *)getParticleSystem
{
    return flames;
}
-(void) setParticleSystem:(CCParticleSystem *)inSystem
{
    flames = inSystem;
    [flames resetSystem];
    [flames setPosVar:ccp(0, 0.5)];
    [flames setStartSize:30.0];
    [flames setGravity:ccp(90, 0)];
    [flames setLife:0.75];
    flames.totalParticles = 30;
    flames.emissionRate = 37.0f;
    flames.duration = -1;
    flames.visible = YES;
    flames.positionType = kCCPositionTypeRelative;
    flames.position = ccp(self.position.x + self.contentSize.width/2, self.position.y + self.contentSize.height/2);
    flames.scale = [self scale];
}
-(void) update:(ccTime)delta
{
    totalDeltaTime += delta;
    speed = speed < maxSpeed ? speed + powf(totalDeltaTime, 2) : speed;
    [self b2Body]->SetLinearVelocity(b2Vec2(-speed, 0));
    flames.position = ccp(self.position.x + self.contentSize.width/2, self.position.y + self.contentSize.height/2);
}
+(id) nodeWithPosition:(CGPoint)position
{
    //generate properties
    PhysicsObjectProperties *properties = [[[PhysicsObjectProperties alloc] init]autorelease];
    properties.position = ccp(position.x, position.y);
    properties.type = b2_kinematicBody;
    properties.friction = 1.0;
    //    properties.mass = 50.0f;
    properties.density = 50.0f;
    properties.restitution = 0.5f;
    properties.objectType = MISSILE;
    
    
    return [[[self alloc] initMissileWithPhysicsProperties:properties Filename:@"missile.png"] autorelease];
}

-(void) dealloc
{
    [self unscheduleUpdate];
    [PhysicsEngine Engine]->world->DestroyBody([self b2Body]);
    //[flames dealloc];
    [super dealloc];
}

@end
