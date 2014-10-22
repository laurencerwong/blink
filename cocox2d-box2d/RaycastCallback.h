//
//  RaycastCallback.h
//  cocox2d-box2d
//
//  Created by Student on 10/6/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import "Box2D.h"
class RayCastCallback : public b2RayCastCallback
{
public:
    RayCastCallback() : fixture_(NULL) {
    }
    
    float32 ReportFixture(b2Fixture* fixture, const b2Vec2& point, const b2Vec2& normal, float32 fraction) {
        fixture_ = fixture;
        point_ = point;
        normal_ = normal;
        fraction_ = fraction;
        return fraction;
    }
    
    b2Fixture* fixture_;
    b2Vec2 point_;
    b2Vec2 normal_;
    float32 fraction_;
    
};
