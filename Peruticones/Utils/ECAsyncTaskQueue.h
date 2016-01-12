//
//  ECAsyncTaskQueue.h
//  TromeEnterate
//
//  Created by RLoza on 9/16/15.
//  Copyright (c) 2015 Empresa Editora El Comercio. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "Constants.h"

#define kASYNCTASKQUEUE_QUEUE_SERIAL_IDENTIFIER "com.eeec.asyncTaskSerial"
#define kASYNCTASKQUEUE_QUEUE_CONCURRENT_IDENTIFIER "com.eeec.asyncTaskConcurrent"

@interface ECAsyncTaskQueue : NSObject

@property (nonatomic, strong, readonly) dispatch_queue_t task_queue_serial;
@property (nonatomic, strong, readonly) dispatch_queue_t task_queue_concurrent;

+(ECAsyncTaskQueue *)shared;

//- (void)addAsyncTaskSerialWithCompletion:(completion_block_t)completion;
//- (void)addAsyncTaskConcurrentWithCompletion:(completion_block_t)completion;

@end
