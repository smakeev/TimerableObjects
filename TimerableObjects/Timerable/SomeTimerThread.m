//
//  SomeTimerThread.m
//  TimerableObjects
//
//  Created by Sergey Makeev on 02/04/2017.
//  Copyright © 2017 SOME projects. All rights reserved.
//

#import "SomeTimerThread.h"

#define LOCK [self lock];
#define UNLOCK [self unlock];

//All defines below for main thread only (Or for code that should be in main thread)

#define UNLOCK_RETURN(a) {if(!main_block) [self unlock]; return a;}

#define INVOKE(a)   dispatch_async(dispatch_get_main_queue(), ^{ \
                  [self performSelector:@selector(_callMake:) onThread:_thread withObject:a waitUntilDone:YES]; \
                   });

#define SYNC_MAIN dispatch_sync(dispatch_get_main_queue(), block
#define ON_MAIN block();

#define MAIN_BLOCK  BOOL main_block = [NSThread mainThread]; \
                    void(^block)() =  ^void(){  \
                                        if(!main_block) \
                                          LOCK

#define END_BLOCK if(!main_block) UNLOCK }; if(!main_block) {\
                     SYNC_MAIN \
                      \
                     ); \
                   } else { \
                   ON_MAIN }

@interface SomeTimerThread()
{
@private
    NSThread *_thread;
    NSMutableArray<id<TimerForManager> > *_timers;
    os_unfair_lock _lock;
    NSRunLoop *_runLoop;
    NSCondition *_condition;
    BOOL _stateStopped;
    BOOL _sleep;
    
}

@property ()NSThread *thread;
@property ()NSRunLoop *runLoop;
@property ()NSMutableArray<id<TimerForManager> > *timers;
@property ()NSCondition *condition;
@property ()BOOL stateStopped;

@property (nonatomic, readwrite)BOOL sleep;

@end

@implementation SomeTimerThread
@synthesize thread = _thread;
@synthesize runLoop = _runLoop;
@synthesize timers = _timers;
@synthesize condition = _condition;
@synthesize stateStopped = _stateStopped;

@synthesize sleep = _sleep;

- (void)lock
{
    os_unfair_lock_lock(&_lock);
}

- (void)unlock
{
    os_unfair_lock_unlock(&_lock);
}

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.timers = [NSMutableArray array];
        self.condition = [[NSCondition alloc] init];
        
    }
    return self;
}

- (void)dealloc
{
    [self stop];
}

- (id) createTimerWithInterval:(NSTimeInterval)interval target:(id) target selector:(SEL) selector  repeats:(BOOL) repeats
{
    return [NSTimer timerWithTimeInterval:interval target:target selector:selector userInfo:nil repeats: repeats];
}

- (BOOL)stopped
{
    return self.stateStopped;
}

- (BOOL)sleeping
{
    return self.sleep;
}

- (void)start
{
    MAIN_BLOCK
    if (!_thread)
    {

        _thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadBody) object:nil];
        self.stateStopped = NO;
        [_thread start];
    }
    [self restartTimers];
    END_BLOCK
}

- (void)stop
{
    MAIN_BLOCK
    [self removeTimers];
    self.stateStopped = YES;
    self.thread = nil;
    END_BLOCK
}

- (void)suspend
{
    MAIN_BLOCK
    if (self.sleep)
    {
        UNLOCK_RETURN()
    }
    [self stopTimers];
    self.sleep = YES;
    [self performSelector:@selector(timersSuspend) onThread:_thread withObject:nil waitUntilDone:NO];
    END_BLOCK
}
//sub function for suspend :on thread
- (void)timersSuspend
{
    [self.condition lock];
    [self.condition wait];
    [self.condition unlock];
}


- (void)awaik
{
   MAIN_BLOCK
   if([self stopped])
   {
       UNLOCK_RETURN()
   }
   self.sleep = NO;
   [self.condition signal];
   [self restartTimers];
  
   END_BLOCK
}

- (void)makeCall:(NSInvocation*)invocation
{
   INVOKE(invocation)
}

//make call sub method. on thread
- (void)_callMake:(NSInvocation*)invocation
{
   [self.runLoop addTimer:[NSTimer timerWithTimeInterval:0.0 invocation:invocation repeats:NO] forMode:NSDefaultRunLoopMode];
}

- (void)threadBody
{
    @autoreleasepool
    {
        if (self.stateStopped)
        {
            return;
        }
        
        self.runLoop = [NSRunLoop currentRunLoop];
        
        while (!self.stateStopped)
        {
            [self.runLoop runUntilDate:[NSDate date]];
        }
        NSLog(@"TimerThread stopped");
    }
}

- (void)addTimer:(id<TimerForManager>)timer
{
    MAIN_BLOCK
    if (![self.timers containsObject:timer])
    {
        [self.timers addObject:timer];
    }
    END_BLOCK
}

- (void)startTimer:(id<TimerForManager>)timer
{
    MAIN_BLOCK
    if ([self.timers containsObject:timer])
    {
         [self performSelector:@selector(timerStart:) onThread:_thread withObject:timer waitUntilDone:YES];
    }
    END_BLOCK
}

//start timer sub method: on timer thread
- (void) timerStart:(id<TimerForManager>)timer
{
    [self.runLoop addTimer:timer.timer forMode:NSDefaultRunLoopMode];
}

- (void)stopTimer:(id<TimerForManager>)timer
{
    MAIN_BLOCK
    if ([self.timers containsObject:timer])
    {
        [self performSelector:@selector(timerInvalidate:) onThread:_thread withObject:timer waitUntilDone:YES];
    }
    END_BLOCK
}

//stop timer sub method: on the timer thread
- (void) timerInvalidate:(id<TimerForManager>)timer
{
    [timer.timer invalidate]; //on the timer thread
}


- (void)removeTimer:(id<TimerForManager>)timer
{
    MAIN_BLOCK
    if ([self.timers containsObject:timer])
    {
        [timer invalidate];
        [self.timers removeObject:timer];
    }
    END_BLOCK
}

/////timers. Internal methods - main thread.
- (void)removeTimers
{
    [self stopTimers];
    [self.timers removeAllObjects];
}

- (void)stopTimers
{
    for (id<TimerForManager> timer in self.timers)
    {
        [timer invalidate];
    }
}

- (void)restartTimers
{
    for (id<TimerForManager>timer in self.timers)
    {
        [timer restart];
    }
}


@end
