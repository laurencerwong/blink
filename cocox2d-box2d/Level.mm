//
//  Level.m
//  cocox2d-box2d
//
//  Created by Keith DeRuiter on 10/6/13.
//  Copyright (c) 2013 Instructor. All rights reserved.
//

#import "Level.h"
#import "cocos2d.h"
#import "BuildingProperties.h"
#import "EntityProperties.h"
#import "EntityTriggerProperties.h"

@implementation Level

@synthesize buildings = buildings_;
@synthesize entities = entities_;
@synthesize entityTriggers = entityTriggers_;
@synthesize length = length_;
@synthesize playerStartLocation = playerStartLocation_;

-(id) initFromJSON:(NSString *)filename
{
    self = [super init];
    if (self) {
        //Init arrays
        buildings_ = [[NSMutableArray alloc] init];
        entities_ = [[NSMutableArray alloc] init];
        entityTriggers_ = [[NSMutableArray alloc] init];
        
        //Load JSON
        /*        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                               ^{
                                   NSData *data = [NSData dataWithContentsOfFile:filename];
                                   [self performSelectorOnMainThread:@selector(parseJSONData:)
                                                          withObject:data
                                                       waitUntilDone:YES];
                               });
        */
        
        NSError *e = nil;
        NSData* data = [NSData dataWithContentsOfFile:filename options:kNilOptions error:&e];
        [self parseJSONData:data];
    }
    return self;
}

-(void) parseJSONData:(NSData *) data
{
    //parse out the json data
    NSLog(@"Creating JSON serialization for %@", data);
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:kNilOptions
                                                           error:&error];
    
    //Parse the level length
    NSLog(@"Parsing length");
    length_ = [[json objectForKey:@"length"] integerValue];
    
    //Parse the player start location
    NSDictionary* playerStartLocation = [json objectForKey:@"playerStartLocation"];
    float x = [[playerStartLocation objectForKey:@"x"] floatValue];
    float y = [[playerStartLocation objectForKey:@"y"] floatValue];
    playerStartLocation_ = ccp(x, y);
    
    NSLog(@"Parsed player start location: (%f, %f)", x, y);
    
    //Parse all of the buildings
    NSArray* buildingsInLevel = [json objectForKey:@"buildings"];
    for(NSDictionary *b in buildingsInLevel)
    {
        float x = [[b objectForKey:@"x"] floatValue];
        float y = [[b objectForKey:@"y"] floatValue];
        int t = [[b objectForKey:@"type"] integerValue];
        BuildingType type = [BuildingProperties buildingTypeFromInteger:t];
        
        [buildings_ addObject: [[[BuildingProperties alloc]
                                 initWithType:type X:x Y:y] autorelease]];
        NSLog(@"Parsed Building: %d at location (%f, %f)", type, x, y);
    }
    
    //Parse all of the entities
    NSArray* entitiesInLevel = [json objectForKey:@"entities"];
    for(NSDictionary *e in entitiesInLevel)
    {
        float x = [[e objectForKey:@"x"] floatValue];
        float y = [[e objectForKey:@"y"] floatValue];
        int t = [[e objectForKey:@"type"] integerValue];
        EntityType type = [EntityProperties entityTypeFromInteger:t];
        [entities_ addObject: [[[EntityProperties alloc]
                                initWithType:type X:x Y:y] autorelease]];
        NSLog(@"Parsed Entity: %d at location (%f, %f)", type, x, y);
    }
    
    //Parse all of the entity triggers
    NSArray* entityTriggersInLevel = [json objectForKey:@"entityTriggers"];
    for(NSDictionary *e in entityTriggersInLevel)
    {
        float xTrigger = [[e objectForKey:@"playerXLocationTrigger"] floatValue];
        float x = [[e objectForKey:@"x"] floatValue];
        float y = [[e objectForKey:@"y"] floatValue];
        int t = [[e objectForKey:@"type"] integerValue];
        EntityType type = [EntityProperties entityTypeFromInteger:t];
        [entityTriggers_ addObject: [[[EntityTriggerProperties alloc]
                                      initWithType:type X:x Y:y Trigger:xTrigger] autorelease]];
        NSLog(@"Parsed EntityTrigger: %d at location (%f, %f) triggered at X= %f", type, x, y, xTrigger);
    }
    //Sort by order of appearance (ascending xTrigger values)
    [entityTriggers_ sortUsingComparator:^NSComparisonResult(id a, id b) {
        EntityTriggerProperties* etpa = (EntityTriggerProperties*) a;
        EntityTriggerProperties* etpb = (EntityTriggerProperties*) b;
        
        NSNumber *aTrigger = [NSNumber numberWithInt: etpa.xTrigger];
        NSNumber *bTrigger = [NSNumber numberWithInt: etpb.xTrigger];
        return [aTrigger compare:bTrigger];
    }];
}

- (void)dealloc
{
    [buildings_ dealloc];
    [entities_ dealloc];
    //[entityTriggers_ dealloc];
    [super dealloc];
}

@end
