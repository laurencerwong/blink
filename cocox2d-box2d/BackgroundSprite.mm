//
//  BackgroundSprite.m
//  cocox2d-box2d
//
//  Created by Keith DeRuiter on 9/23/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import "BackgroundSprite.h"

@implementation BackgroundSprite

- (id)initWithFile:(NSString *)filename
{
    self = [super initWithFile:filename];
    if (self) {
        
    }
    return self;
}

+(id) nodeWithFile:(NSString *)filename
{
    return [[[self alloc] initWithFile:filename] autorelease];
}

@end
