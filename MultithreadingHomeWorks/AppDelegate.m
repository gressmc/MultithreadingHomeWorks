//
//  AppDelegate.m
//  MultithreadingHomeWorks
//
//  Created by gressmc on 10/11/14.
//  Copyright (c) 2014 gressmc. All rights reserved.
//

#import "AppDelegate.h"
#import "RRStudent.h"

@interface AppDelegate ()
@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    RRRange range = {100,500};
  
    RRStudent* stud = [[RRStudent alloc] initWithName:@"Ivan"];
    RRStudent* stud2 = [[RRStudent alloc] initWithName:@"Lena"];
    RRStudent* stud3 = [[RRStudent alloc] initWithName:@"Dima"];
    RRStudent* stud4 = [[RRStudent alloc] initWithName:@"Katya"];
    RRStudent* stud5 = [[RRStudent alloc] initWithName:@"Roma"];
    
    NSArray* arrayStud = @[stud,stud2,stud3,stud4,stud5];
    
    VoidBlockString studBlock = ^(NSString* name, NSInteger num, double endTime){
        NSLog(@"%@ Отгаданно число %ld за %f", name, num, endTime);
    };
    // Задаем вопрос студентам в отгадайке
    for (RRStudent* stud in arrayStud) {
        [stud guessTheNumber:432
                       range:range
                   studBlock:studBlock];
    }
    
    return YES;
}
@end
