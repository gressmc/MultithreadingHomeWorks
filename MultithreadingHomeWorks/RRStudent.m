//
//  RRStudent.m
//  MultithreadingHomeWorks
//
//  Created by gressmc on 10/11/14.
//  Copyright (c) 2014 gressmc. All rights reserved.
//

#import "RRStudent.h"

@implementation RRStudent

+(dispatch_queue_t) sharedInstance{
    static dispatch_queue_t  queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("com.RR.Multithreading.HomeWorks", DISPATCH_QUEUE_CONCURRENT);
    });
    return queue;
}

+(NSOperationQueue*) sharedOperation{
    static NSOperationQueue* sharedOperation = nil;
    @synchronized ([NSOperationQueue class])
    {
        if (!sharedOperation) {
            sharedOperation = [[NSOperationQueue alloc] init];
        }
    }
return sharedOperation;
}

-(instancetype)initWithName:(NSString*)name{
    self = [super init];
    if (self) {
        self.name = name;
    }
    return self;
}

- (instancetype)init{
    @throw [NSException exceptionWithName:@"Don't use init & new"
                                   reason:@"Use initWithName:(NSString*)name"
                                 userInfo:nil];
    return nil;
}

-(void)guessTheNumberOperation:(NSInteger)num
                range:(RRRange)range
            studBlock:(VoidBlockString)studBlock{
    
    //
    [[RRStudent sharedOperation] addOperationWithBlock:^{
       
        NSInteger minR = range.minRangeNumber;
        NSInteger maxR = range.maxRangeNumber;
        __block NSInteger number = 0;
        __block double endTime = 0;
        
        double startTime = CACurrentMediaTime();
        while (!(number == num)) number = arc4random_uniform((u_int32_t)(maxR-minR)+1) + minR ;
        endTime = CACurrentMediaTime()-startTime;
        __weak RRStudent* weakSelf = self;
        studBlock(weakSelf.name, number, endTime);
    }];
    
}

-(void)guessTheNumber:(NSInteger)num
                range:(RRRange)range
            studBlock:(VoidBlockString)studBlock{
    
    // Достаем диапазон чисел из параметра
    NSInteger minR = range.minRangeNumber;
    NSInteger maxR = range.maxRangeNumber;
    __block NSInteger number = 0;
    __block double endTime = 0;
    
    // Создаем очередь для потока
    dispatch_async([RRStudent sharedInstance], ^{
            double startTime = CACurrentMediaTime();
            while (!(number == num)) number = arc4random_uniform((u_int32_t)(maxR-minR)+1) + minR ;
            endTime = CACurrentMediaTime()-startTime;
        __weak id weakSelf = self;
        studBlock([weakSelf name], number, endTime);
    });
}
@end
