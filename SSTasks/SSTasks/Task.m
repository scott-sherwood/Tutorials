//
//  Task.m
//  MyTasks
//
//  Created by Scott Sherwood on 17/11/2011.
//  Copyright (c) 2011 Scott Sherwood. All rights reserved.
//

#import "Task.h"

@implementation Task

@synthesize name,taskID;


-(id)init{
    return [self initWithName:nil ];
}

-(id)initWithDictionary:(NSDictionary *)dict{
    
    if(self!=nil){
        self.taskID = [[dict objectForKey:@"taskID"] integerValue];
        self.name = [dict objectForKey:@"name"];
    }
    return self;
}

-(id)initWithName:(NSString *)aName
{
    
    if(self!=nil){
        NSDate *date = [NSDate date];
        
        self.taskID = [date hash];
        self.name = aName;
    }
    return self;
}


-(NSDictionary *)toDictionary{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.name forKey:@"name"];
    [dict setObject:[[NSNumber numberWithInteger:self.taskID] stringValue] forKey:@"taskID"];
    return dict;
}

@end
