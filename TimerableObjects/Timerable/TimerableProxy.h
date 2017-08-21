//
//  TimerableProxy.h
//  TimerableObjects
//
//  Created by Sergey Makeev on 03/04/2017.
//  Copyright © 2017 SOME projects. All rights reserved.
//

#import <Foundation/Foundation.h>


#define MAKE_TIMERABLE(a) a = (__typeof(a))[TimerableProxy instanceOfObject:a];
#define TIMERABLE(a) a<TimerBuilder>*
#define TIMER(a) a<TimerProtocol>*

@protocol TimerProtocol;

/*Delegate is optional. If you don't provide it, target is a delegate. If target does not implement methods, it will be ignored */
@protocol TmerProxyDelegate <NSObject>
@optional
- (void) timerStarted:(id<TimerProtocol>)timer;
- (void) timerInvalidated:(id<TimerProtocol>)timer;
- (void) timerDestroyed:(NSString*)timerName;
- (void) timer:(id<TimerProtocol>)timer tickedWithInvocation:(NSInvocation*)invocation;

@end

@protocol TimerBuilder <NSObject>

@property (nonatomic, readonly)id target;

- (id<TimerProtocol>)timer; //default values. Defaulr interval = 1
                            //default name ""
                            //default repeats YES
                            //count is used instead of repeats. If use repeats YES - infinity count
                            //delegate nil - by default(when nil) target is a delegate
                            //delegate queue nil
                            //queue nil - queue for timer call.

- (id<TimerProtocol>)timerWithName:(NSString*)name;
- (id<TimerProtocol>)timerWithInterval:(NSTimeInterval)interval;
- (id<TimerProtocol>)timerWithInterval:(NSTimeInterval)interval repeats:(BOOL)repeats;
- (id<TimerProtocol>)timerWithInterval:(NSTimeInterval)interval count:(NSUInteger)count;
- (id<TimerProtocol>)timerWithName:(NSString*)name interval:(NSTimeInterval)interval;
- (id<TimerProtocol>)timerWithName:(NSString*)name interval:(NSTimeInterval)interval repeats:(BOOL)repeats;
- (id<TimerProtocol>)timerWithName:(NSString*)name interval:(NSTimeInterval)interval count:(NSUInteger)count;
- (id<TimerProtocol>)timerWithInterval:(NSTimeInterval)interval repeats:(BOOL)repeats delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue;
- (id<TimerProtocol>)timerWithInterval:(NSTimeInterval)interval count:(NSUInteger)count delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue;
- (id<TimerProtocol>)timerWithInterval:(NSTimeInterval)interval repeats:(BOOL)repeats queue:(dispatch_queue_t)queue;
- (id<TimerProtocol>)timerWithInterval:(NSTimeInterval)interval count:(NSUInteger)count queue:(dispatch_queue_t)queue;
- (id<TimerProtocol>)timerWithName:(NSString*)name interval:(NSTimeInterval)interval repeats:(BOOL)repeats delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue;
- (id<TimerProtocol>)timerWithName:(NSString*)name interval:(NSTimeInterval)interval count:(NSUInteger)count delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue;
- (id<TimerProtocol>)timerWithName:(NSString*)name interval:(NSTimeInterval)interval repeats:(BOOL)repeats queue:(dispatch_queue_t)queue;
- (id<TimerProtocol>)timerWithName:(NSString*)name interval:(NSTimeInterval)interval count:(NSUInteger)count queue:(dispatch_queue_t)queue;
- (id<TimerProtocol>)timerWithDelegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue queue:(dispatch_queue_t)queue;
- (id<TimerProtocol>)timerWithInterval:(NSTimeInterval)interval delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue queue:(dispatch_queue_t)queue;
- (id<TimerProtocol>)timerWithInterval:(NSTimeInterval)interval repeats:(BOOL)repeats delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue queue:(dispatch_queue_t)queue;
- (id<TimerProtocol>)timerWithInterval:(NSTimeInterval)interval count:(NSInteger)count delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue queue:(dispatch_queue_t)queue;
- (id<TimerProtocol>)timerWithName:(NSString*)name interval:(NSTimeInterval)interval count:(NSInteger)count delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue queue:(dispatch_queue_t)queue;
- (id<TimerProtocol>)timerWithName:(NSString*)name interval:(NSTimeInterval)interval repeats:(BOOL)repeats delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue queue:(dispatch_queue_t)queue;

//auto starting timers. Don't need to call start. Will start after method calling
- (id<TimerProtocol>)autoTimerNow:(BOOL)now; //default values. Defaulr interval = 1
//default name ""
//default repeats YES
//count is used instead of repeats. If use repeats YES - infinity count
//delegate nil - by default(when nil) target is a delegate
//delegate queue nil
//queue nil - queue for timer call.

- (id<TimerProtocol>)autoTimerWithName:(NSString*)name now:(BOOL)now;
- (id<TimerProtocol>)autoTimerWithInterval:(NSTimeInterval)interval now:(BOOL)now;
- (id<TimerProtocol>)autoTimerWithInterval:(NSTimeInterval)interval repeats:(BOOL)repeats now:(BOOL)now;
- (id<TimerProtocol>)autoTimerWithInterval:(NSTimeInterval)interval count:(NSUInteger)count now:(BOOL)now;
- (id<TimerProtocol>)autoTimerWithName:(NSString*)name interval:(NSTimeInterval)interval now:(BOOL)now;
- (id<TimerProtocol>)autoTimerWithName:(NSString*)name interval:(NSTimeInterval)interval repeats:(BOOL)repeats now:(BOOL)now;
- (id<TimerProtocol>)autoTimerWithName:(NSString*)name interval:(NSTimeInterval)interval count:(NSUInteger)count now:(BOOL)now;
- (id<TimerProtocol>)autoTimerWithInterval:(NSTimeInterval)interval repeats:(BOOL)repeats delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue now:(BOOL)now;
- (id<TimerProtocol>)autoTimerWithInterval:(NSTimeInterval)interval count:(NSUInteger)count delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue now:(BOOL)now;
- (id<TimerProtocol>)autoTimerWithInterval:(NSTimeInterval)interval repeats:(BOOL)repeats queue:(dispatch_queue_t)queue now:(BOOL)now;
- (id<TimerProtocol>)autoTimerWithInterval:(NSTimeInterval)interval count:(NSUInteger)count queue:(dispatch_queue_t)queue now:(BOOL)now;
- (id<TimerProtocol>)autoTimerWithName:(NSString*)name interval:(NSTimeInterval)interval repeats:(BOOL)repeats delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue now:(BOOL)now;
- (id<TimerProtocol>)autoTimerWithName:(NSString*)name interval:(NSTimeInterval)interval count:(NSUInteger)count delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue now:(BOOL)now;
- (id<TimerProtocol>)autoTimerWithName:(NSString*)name interval:(NSTimeInterval)interval repeats:(BOOL)repeats queue:(dispatch_queue_t)queue now:(BOOL)now;
- (id<TimerProtocol>)autoTimerWithName:(NSString*)name interval:(NSTimeInterval)interval count:(NSUInteger)count queue:(dispatch_queue_t)queue now:(BOOL)now;
- (id<TimerProtocol>)autoTimerWithDelegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue queue:(dispatch_queue_t)queue now:(BOOL)now;
- (id<TimerProtocol>)autoTimerWithInterval:(NSTimeInterval)interval delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue queue:(dispatch_queue_t)queue now:(BOOL)now;
- (id<TimerProtocol>)autoTimerWithInterval:(NSTimeInterval)interval repeats:(BOOL)repeats delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue queue:(dispatch_queue_t)queue now:(BOOL)now;
- (id<TimerProtocol>)autoTimerWithInterval:(NSTimeInterval)interval count:(NSInteger)count delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue queue:(dispatch_queue_t)queue now:(BOOL)now;
- (id<TimerProtocol>)autoTimerWithName:(NSString*)name interval:(NSTimeInterval)interval count:(NSInteger)count delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue queue:(dispatch_queue_t)queue now:(BOOL)now;
- (id<TimerProtocol>)autoTimerWithName:(NSString*)name interval:(NSTimeInterval)interval repeats:(BOOL)repeats delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue queue:(dispatch_queue_t)queue now:(BOOL)now;

@end

@protocol TimerProtocol <NSObject>

@property (nonatomic, readonly) NSString *name;
@property (atomic, readwrite) BOOL autoDestroy;
@property (nonatomic ,readonly) id target;

- (void)invalidate;
- (void)destroy;
- (void)restart;
- (void)restart:(BOOL)now;
- (void)start;
- (void)start:(BOOL)now;
- (void)stronglefyTarget;
- (void)freeTarget;

@end

@protocol TimerForManager <TimerProtocol>
 @property (nonatomic, readonly) id timer;
@end


@interface TimerableProxy : NSProxy <TimerBuilder>
@property (nonatomic, readonly)id target;
+ (TimerableProxy*) instanceOfObject:(id)object;
@end
