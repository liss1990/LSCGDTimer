//
//  LSGCDTimer.m
//  LSGCDTimer
//
//  Created by 李丝思 on 2019/10/9.
//  Copyright © 2019 思. All rights reserved.
//

#import "LSGCDTimer.h"

static NSMutableDictionary   *___timers;
dispatch_semaphore_t  ___semaphore;


@implementation LSGCDTimer


+(void)initialize{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ___timers = [NSMutableDictionary dictionary];
        ___semaphore = dispatch_semaphore_create(1);
    });
}



+(NSString *)execTask:(void (^)(void))task start:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async{
    if (!task || start < 0 || (interval <= 0 && repeats)) return nil;
    
    ///创建队列
    dispatch_queue_t queue = async ? dispatch_get_global_queue(0, 0) : dispatch_get_main_queue();
    
    //创建timer
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, start * NSEC_PER_SEC, interval * NSEC_PER_SEC);
    
    //创建标示 保存当前的timer
    
    dispatch_semaphore_wait(___semaphore, DISPATCH_TIME_FOREVER);
    
    NSString *timeName = [NSString stringWithFormat:@"%zd",___timers.count];
    ___timers[timeName] = timer;
    
    dispatch_semaphore_signal(___semaphore);
    dispatch_source_set_event_handler(timer, ^{
        task();
        ///新增判断是否要停止timer
        if(!repeats){
            [self cancelTask:timeName];
        }
        
    });
    dispatch_resume(timer);
    
    return timeName;
}

+(void)cancelTask:(NSString *)name{
    
    if(name.length == 0) return;
    
    dispatch_semaphore_wait(___semaphore, DISPATCH_TIME_FOREVER);
    dispatch_source_t time = ___timers[name];
    if(time){
        dispatch_source_cancel(time);
        [___timers removeObjectForKey:name];
    }
    dispatch_semaphore_signal(___semaphore);
    
    
}


@end
