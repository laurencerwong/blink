//
//  ContactListener.h
//  cocox2d-box2d
//
//  Created by Student on 10/6/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Box2D.h"
#import <vector>

struct ContactPair {
    b2Fixture *fixtureA;
    b2Fixture *fixtureB;
    //std::vector<b2Vec2> contactPoints;
    b2Vec2 contactPoint;
    bool operator==(const ContactPair& other) const
    {
        return (fixtureA == other.fixtureA) && (fixtureB == other.fixtureB);
    }
    };
    
class ContactListener : public b2ContactListener
{
public:
    std::vector<ContactPair>contacts;
    
    ContactListener();
    ~ContactListener();
    
    virtual void BeginContact(b2Contact* contact);
    virtual void EndContact(b2Contact* contact);
    virtual void PreSolve(b2Contact* contact, const b2Manifold* oldManifold);
    virtual void PostSolve(b2Contact* contact, const b2ContactImpulse* impulse);
};
