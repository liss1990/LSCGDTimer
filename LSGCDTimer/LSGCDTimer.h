//
//  LSGCDTimer.h
//  LSGCDTimer
//
//  Created by 李丝思 on 2019/10/9.
//  Copyright © 2019 思. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSGCDTimer : NSObject

/// 倒计时 Block回调方式
/// @param task block
/// @param start 开始时间
/// @param interval 间隔时间
/// @param repeats 是否重复
/// @param async 是否异步队列
+(NSString *)execTask:(void(^)(void))task
            start:(NSTimeInterval)start
            interval:(NSTimeInterval)interval
            repeats:(BOOL)repeats
                async:(BOOL)async;
///取消定时器
+ (void)cancelTask:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
