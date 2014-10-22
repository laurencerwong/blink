//
//  Meteor.m
//  cocox2d-box2d
//
//  Created by Laurence Wong on 10/19/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import "Meteor.h"

@implementation Meteor

-(id) initMeteorWithPhysicsProperties:(PhysicsObjectProperties *)properties
                             Filename:(NSString *) filename
                          TargetPoint:(CGPoint)targetPoint
                                Speed:(float)inSpeed
{
    self = [super initWithPhysicsProperties:properties Filename:filename];
    if (self) {
        speed = inSpeed;
        CGPoint newLinearVelocity = ccpSub(targetPoint, properties.position);
        newLinearVelocity = ccpNormalize(newLinearVelocity);
        newLinearVelocity = ccpMult(newLinearVelocity, speed);
        [self b2Body]->SetLinearVelocity(b2Vec2(newLinearVelocity.x, newLinearVelocity.y));
        //flames = [CCParticleSmoke node];
//                [self addChild:flames z:0];
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
    flames.totalParticles = 30;
    flames.emissionRate = 37.0f;
    flames.duration = -1;
    flames.life = 1.0;
    flames.visible = YES;
    flames.gravity = ccp([self b2Body]->GetLinearVelocity().x * -1,
                         [self b2Body]->GetLinearVelocity().y * -1);
    flames.speed = 1;
    [flames setStartSize:40];
    [flames setEndSize:0];
    flames.positionType = kCCPositionTypeRelative;
    flames.position = ccp(0,self.contentSize.height);
    flames.scale = [self scale];

}

-(void) update:(ccTime)delta
{
    flames.position = ccp(self.position.x - self.contentSize.width/2, self.position.y + self.contentSize.height/2);
    if(self.position.y < -self.contentSize.width/2 || [[PhysicsEngine Engine] hasCollision:self.b2Body->GetFixtureList()])
    {
        self.destroyMe = YES;
    }
}

+(id) nodeWithPosition:(CGPoint)position TargetPosition:(CGPoint)targetPoint Speed:(float)speed
{
    //generate properties
    PhysicsObjectProperties *properties = [[[PhysicsObjectProperties alloc] init]autorelease];
    properties.position = ccp(position.x, position.y);
    properties.type = b2_dynamicBody;
    properties.friction = 1.0;
    //    properties.mass = 50.0f;
    properties.density = 50.0f;
    properties.restitution = 0.5f;
    properties.objectType = METEOR;
    
    
    return [[[self alloc] initMeteorWithPhysicsProperties:properties
                                                 Filename:@"meteorite.png"
                                              TargetPoint:targetPoint
                                                    Speed:speed] autorelease];
}

-(void) dealloc
{
    [self unscheduleUpdate];
    //[self removeChild:flames];
    [PhysicsEngine Engine]->world->DestroyBody([self b2Body]);
    //[flames dealloc];
    [super dealloc];
}

@end
