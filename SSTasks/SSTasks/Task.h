//
//  Task.h
//  MyTasks
//
//  Created by Scott Sherwood on 17/11/2011.
//  Copyright (c) 2011 Scott Sherwood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject
{
    NSInteger taskID;
    NSString *name;
}

@property(assign,nonatomic)NSInteger taskID;
@property(strong,nonatomic)NSString *name;


-(id)initWithDictionary:(NSDictionary *)dict;
-(id)initWithName:(NSString *)aName;

-(NSDictionary *)toDictionary;

@end
