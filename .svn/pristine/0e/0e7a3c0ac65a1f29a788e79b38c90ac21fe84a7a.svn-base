//
//  LevelSelectSprite.m
//  cocox2d-box2d
//
//  Created by Laurence Wong on 10/22/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import "LevelSelectSprite.h"
#import "GameplayScene.h"

@implementation LevelSelectSprite
@synthesize levelName = levelName_;
@synthesize text = text_;


- (id)initWithSprite:(NSString*)filename LevelName:(NSString*)levelName LevelNumber:(int)levelNum Target:(id)target Selector:(SEL)sel
{
    self = [super initWithNormalImage:filename selectedImage:filename disabledImage:filename target:target selector:sel];
    if (self) {
        self.levelName = levelName;
        self.text = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", levelNum] fontName:@"Marker Felt" fontSize:25];
        self.text.position = ccp(25, 25);
        [self addChild:self.text];
    }
    return self;
}

+(id) nodeWithlevelName:(NSString *)levelName LevelNum:(int)levelNum Target:(id)target Selector:(SEL)sel
{
    return [[[self alloc] initWithSprite:@"levelsprite.png" LevelName:levelName LevelNumber:levelNum Target:target Selector: sel] autorelease];
}

-(void) setImagePosition:(CGPoint)position
{
    self.text.position = position;
    _position = ccpAdd(position, ccp(100, 0));
}
@end

