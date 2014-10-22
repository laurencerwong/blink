//
//  GamePhysicsObject.m
//  cocox2d-box2d
//
//  Created by Keith DeRuiter on 10/2/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import "GamePhysicsObject.h"
#import "PhysicsEngine.h"

@implementation GamePhysicsObject
@synthesize  objectType = objectType_;
@synthesize destroyMe = destroyMe_;

-(id) initWithPhysicsProperties:(PhysicsObjectProperties *)properties
                       Filename:(NSString*)filename
{
    self = [super initWithFile:filename];
    if(self)
    {
        //set the boxsize to the texture
        b2Vec2 boxSize;
        boxSize.Set(self.textureRect.size.width, self.textureRect.size.height);
        properties.boxSize = boxSize;
        
        [self definePhysicsWithProperties:properties];

    }
    return self;
}

-(void) definePhysicsWithProperties:(PhysicsObjectProperties *)properties
{
    //    CCLOG(@"Add physics object %0.2f x %02.f",p.x,p.y);
    
	// Define the dynamic body.
	//Set up a squared box in the physics world
	b2BodyDef bodyDef;
	bodyDef.type = properties.type;
	bodyDef.position.Set(properties.position.x/PTM_RATIO, properties.position.y/PTM_RATIO);
    b2Body *body = [PhysicsEngine Engine]->world->CreateBody(&bodyDef);
	
	// Define another box shape for our dynamic body.
	b2PolygonShape dynamicBox;
	dynamicBox.SetAsBox(properties.boxSize.x/(2*PTM_RATIO), properties.boxSize.y/(2*PTM_RATIO));    //These are mid points for our box
    
	// Define the dynamic body fixture.
	b2FixtureDef fixtureDef;
	fixtureDef.shape = &dynamicBox;
	fixtureDef.density = properties.density;
	fixtureDef.friction = properties.friction;
    fixtureDef.restitution = properties.restitution;
    fixtureDef.isSensor = properties.isSensor;
    
	body->CreateFixture(&fixtureDef);

    /*NSMutableData *typeData = [NSMutableData dataWithLength:sizeof(GameObjectType)];
    GameObjectType* type = (GameObjectType *)[typeData mutableBytes];
    *type = properties.objectType;*/
    self.objectType = properties.objectType;
    body->SetUserData((void*)self);
	
	[self setPTMRatio: PTM_RATIO];
	[self setB2Body: body];
	[self setPosition: ccp(properties.position.x, properties.position.y)];
}

-(void) placeOnTopOfObject:(GamePhysicsObject *)object AtXPosition:(float)x
{
    float topOfObject = object.position.y + object.contentSize.height/2;
    [self position] = ccp(x, topOfObject + [self contentSize].height/2);
}

@end
