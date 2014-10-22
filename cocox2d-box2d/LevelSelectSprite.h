//
//  LevelSelectSprite.h
//  cocox2d-box2d
//
//  Created by Laurence Wong on 10/22/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import "cocos2d.h"

@interface LevelSelectSprite : CCMenuItemImage
{
    NSString *levelName_;
    CCLabelTTF *text_;
};

+(id) nodeWithlevelName:(NSString *)levelName LevelNum:(int)levelNum Target:(id)target Selector:(SEL)sel;
-(void) setImagePosition:(CGPoint)position;

@property(copy) NSString* levelName;
@property CCLabelTTF* text;
@end
