//
//  RRStudent.h
//  MultithreadingHomeWorks
//
//  Created by gressmc on 10/11/14.
//  Copyright (c) 2014 gressmc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^VoidBlockString)(NSString*,NSInteger,double);

typedef struct RRRange {
    NSInteger minRangeNumber;
    NSInteger maxRangeNumber;
} RRRange;

@interface RRStudent : NSObject

@property(strong,nonatomic)NSString* name;
@property(assign,nonatomic)RRRange range;
@property(assign,nonatomic)NSInteger num;

-(instancetype)initWithName:(NSString*)name;

-(void)guessTheNumber:(NSInteger)num
                range:(RRRange)range
            studBlock:(VoidBlockString)studBlock;

-(void)guessTheNumberOperation:(NSInteger)num
                range:(RRRange)range
             studBlock:(VoidBlockString)studBlock;
+(NSOperationQueue*) sharedOperation;

@end
