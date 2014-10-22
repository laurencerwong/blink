//
//  ContactListener.m
//  cocox2d-box2d
//
//  Created by Student on 10/6/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import "ContactListener.h"

ContactListener::ContactListener() : contacts() {
}

ContactListener::~ContactListener() {
}

void ContactListener::BeginContact(b2Contact* contact) {
    // We need to copy out the data because the b2Contact passed in
    // is reused.

    ContactPair myContact = { contact->GetFixtureA(), contact->GetFixtureB()};
        myContact.contactPoint = contact->GetManifold()->localPoint;
    contacts.push_back(myContact);
}

void ContactListener::EndContact(b2Contact* contact) {
    ContactPair myContact = { contact->GetFixtureA(), contact->GetFixtureB() };
    std::vector<ContactPair>::iterator pos;
    pos = std::find(contacts.begin(), contacts.end(), myContact);
    if (pos != contacts.end()) {
        contacts.erase(pos);
    }
}

void ContactListener::PreSolve(b2Contact* contact,
                                 const b2Manifold* oldManifold) {
}

void ContactListener::PostSolve(b2Contact* contact,
                                  const b2ContactImpulse* impulse) {
}