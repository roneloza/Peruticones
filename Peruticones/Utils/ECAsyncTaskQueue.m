
//
//  ECAsyncTaskQueue.m
//  TromeEnterate
//
//  Created by RLoza on 9/16/15.
//  Copyright (c) 2015 Empresa Editora El Comercio. All rights reserved.
//

#import "ECAsyncTaskQueue.h"

@interface ECAsyncTaskQueue()

@property (nonatomic, strong, readwrite) dispatch_queue_t task_queue_serial;
@property (nonatomic, strong, readwrite) dispatch_queue_t task_queue_concurrent;

@end

@implementation ECAsyncTaskQueue

+ (ECAsyncTaskQueue*)shared {
    
    static ECAsyncTaskQueue *_shared = nil;
    
    if (!_shared) {
        
        _shared = [[super allocWithZone:nil] init];
    }
    
    return _shared;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    
    return [self shared];
}

- (dispatch_queue_t)task_queue_serial {
    
    if (!_task_queue_serial) {
        
        _task_queue_serial = dispatch_queue_create(kASYNCTASKQUEUE_QUEUE_SERIAL_IDENTIFIER,
                                                         DISPATCH_QUEUE_SERIAL);
    }
    
    return _task_queue_serial;
}

- (dispatch_queue_t)task_queue_concurrent {
    
    if (!_task_queue_concurrent) {
        
        _task_queue_concurrent = dispatch_queue_create(kASYNCTASKQUEUE_QUEUE_SERIAL_IDENTIFIER,
                                                   DISPATCH_QUEUE_SERIAL);
    }
    
    return _task_queue_concurrent;
}

@end
