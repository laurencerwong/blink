//
//  PhysicsEngine.m
//  cocox2d-box2d
//
//  Created by Laurence Wong on 9/27/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import "PhysicsEngine.h"

@implementation PhysicsEngine

+(PhysicsEngine *)Engine
{
    static PhysicsEngine *physicsEngineSingleton;
    
    if(!physicsEngineSingleton)
        //If physics engine does not exist, then create it
    {
        physicsEngineSingleton = [[PhysicsEngine alloc] init];
    }
    return physicsEngineSingleton;
}

-(BOOL)areColliding:(b2Fixture *)fixA FixtureB:(b2Fixture *)fixB
{
    std::vector<ContactPair>::iterator pos;
    for(pos = contactListener->contacts.begin();
        pos != contactListener->contacts.end(); ++pos) {
        ContactPair contact = *pos;
        
        if ((contact.fixtureA == fixA && contact.fixtureB == fixB) ||
            (contact.fixtureA == fixB && contact.fixtureB == fixA))
        {
            //NSLog(@"SOMETHING HIT SOMETHING ELSE");
            return YES;
        }
    }
    return NO;
}
-(BOOL)hasCollision:(b2Fixture *)fix //Array of collision 
{
    std::vector<ContactPair>::iterator pos;
    for(pos = contactListener->contacts.begin();
        pos != contactListener->contacts.end(); ++pos) {
        ContactPair contact = *pos;
        
        if (contact.fixtureA == fix || contact.fixtureB == fix)
        {
            //NSLog(@"SOMETHING HIT SOMETHING");
            return YES;
        }
    }
    return NO;
}
-(BOOL)hasCollision:(b2Fixture *)fix WithDetails:(NSMutableArray **)details
{
    *details = [[NSMutableArray alloc] init];
    std::vector<ContactPair>::iterator pos;
    for(pos = contactListener->contacts.begin();
        pos != contactListener->contacts.end(); ++pos) {
        ContactPair contact = *pos;
        if (contact.fixtureA == fix)
        {
            GamePhysicsObject *type = (GamePhysicsObject*)contact.fixtureB->GetBody()->GetUserData();
            CollisionDetail *detail;
            detail = [[[CollisionDetail alloc] init] autorelease];
            [detail SetProperties:type WithPoint:ccp(contact.contactPoint.x, contact.contactPoint.y)];
            [*details addObject:detail];
            //return YES;
        }
        else if(contact.fixtureB == fix)
        {
            GamePhysicsObject *type = (GamePhysicsObject*)contact.fixtureA->GetBody()->GetUserData();
            CollisionDetail *detail;
            detail = [[[CollisionDetail alloc] init] autorelease];
            [detail SetProperties:type WithPoint:ccp(contact.contactPoint.x, contact.contactPoint.y)];
            [*details addObject:detail];
            //return YES;
        }
    }
    if([*details count] > 0)
    {
        return YES;
    }
    return NO;
}

-(void) deleteEverything
{
    
}


-(void) initPhysics
{
    b2Vec2 gravity;
    gravity.Set(0.0f, -30.0f);
	world = new b2World(gravity);
	
	
	// Do we want to let bodies sleep?
	world->SetAllowSleeping(true);
	
	world->SetContinuousPhysics(true);
	
	m_debugDraw = new GLESDebugDraw( PTM_RATIO );
	world->SetDebugDraw(m_debugDraw);
	
	uint32 flags = 0;
	flags += b2Draw::e_shapeBit;
	//		flags += b2Draw::e_jointBit;
	//		flags += b2Draw::e_aabbBit;
	//		flags += b2Draw::e_pairBit;
	//		flags += b2Draw::e_centerOfMassBit;
	m_debugDraw->SetFlags(flags);
	contactListener = new ContactListener();
    world->SetContactListener(contactListener);
}
-(void) deletePhysics
{
    delete contactListener;
    delete world;
    world = NULL;
}
-(void) update:(ccTime)delta
{
    world->Step(delta, 2, 2);
}

-(void) dealloc
{
    [self deletePhysics];
    [super dealloc];
}

@end
