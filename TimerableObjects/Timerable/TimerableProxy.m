//
//  TimerableProxy.m
//  TimerableObjects
//
//  Created by Sergey Makeev on 03/04/2017.
//  Copyright © 2017 SOME projects. All rights reserved.
//

#import "TimerableProxy.h"
#import "SomeTimerThread.h"


extern id<ManagerForTimerProtocol> getManagerForTimer(id<TimerProtocol> timer);

@class TimerProxy;

@interface TimerProxy : NSProxy <TimerProtocol, TimerForManager>
{
    __weak id _target;
    NSInvocation *_invocation;
    __weak id<ManagerForTimerProtocol> _manager;
    NSTimeInterval _interval;
    BOOL _repeats;
    NSUInteger _totoalCount;
    NSUInteger _iterationsDone;
    
    dispatch_queue_t _timerQueue;
    dispatch_queue_t _delegateQueue;
    __weak id<TmerProxyDelegate> _delegate;
    NSString *_name;
    id _timer;
    
    //For stronglefying
    __strong id _strongTarget;
}

@property ()NSInvocation *invocation;
@property (nonatomic, readonly)NSTimer *timer;

- (instancetype)init:(id)target withName:(NSString*)name interval:(NSTimeInterval)interval repeats:(BOOL)repeats count:(NSUInteger)count delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue queueu:(dispatch_queue_t)timerQueue;

@end

@interface AutoTimerProxy : TimerProxy
{
    BOOL _now;
}

- (instancetype)init:(id)target withName:(NSString*)name interval:(NSTimeInterval)interval repeats:(BOOL)repeats count:(NSUInteger)count delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue queueu:(dispatch_queue_t)timerQueue now:(BOOL)now;

@end

@implementation TimerableProxy
{
    __weak id _target;
}

@synthesize target = _target;

-(instancetype)initWithTarget:(id)target
{
    _target = target;
    return self;
}

+ (TimerableProxy*) instanceOfObject:(id)object
{
    return [[TimerableProxy alloc] initWithTarget:object];
}

- (NSMethodSignature*)methodSignatureForSelector:(SEL)sel
{
    return [_target methodSignatureForSelector:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return _target;
}

//creating

//default values. Defaulr interval = 1
//default name ""
//default repeats YES
//count is used instead of repeats. If use repeats YES - infinity count
//delegate nil
//delegate queue nil
//queue nil

- (id<TimerProtocol>)timer
{
    return [[TimerProxy alloc] init:self.target withName:@"" interval:1.0 repeats:YES count:0 delegate:nil delegateQueue:nil queueu:nil];
}

- (id<TimerProtocol>)timerWithName:(NSString*)name
{
    return [[TimerProxy alloc] init:self.target withName:name interval:1.0 repeats:YES count:0 delegate:nil delegateQueue:nil queueu:nil];
}

- (id<TimerProtocol>)timerWithInterval:(NSTimeInterval)interval
{
    return [[TimerProxy alloc] init:self.target withName:@"" interval:interval repeats:YES count:0 delegate:nil delegateQueue:nil queueu:nil];
}

- (id<TimerProtocol>)timerWithInterval:(NSTimeInterval)interval repeats:(BOOL)repeats
{
    return [[TimerProxy alloc] init:self.target withName:@"" interval:interval repeats:repeats count:0 delegate:nil delegateQueue:nil queueu:nil];
}

- (id<TimerProtocol>)timerWithInterval:(NSTimeInterval)interval count:(NSUInteger)count
{
    return [[TimerProxy alloc] init:self.target withName:@"" interval:interval repeats:YES count:count delegate:nil delegateQueue:nil queueu:nil];
}

- (id<TimerProtocol>)timerWithName:(NSString*)name interval:(NSTimeInterval)interval
{
     return [[TimerProxy alloc] init:self.target withName:name interval:interval repeats:YES count:0 delegate:nil delegateQueue:nil queueu:nil];
}

- (id<TimerProtocol>)timerWithName:(NSString*)name interval:(NSTimeInterval)interval repeats:(BOOL)repeats
{
     return [[TimerProxy alloc] init:self.target withName:name interval:interval repeats:repeats count:0 delegate:nil delegateQueue:nil queueu:nil];
}

- (id<TimerProtocol>)timerWithName:(NSString*)name interval:(NSTimeInterval)interval count:(NSUInteger)count
{
    return [[TimerProxy alloc] init:self.target withName:name interval:interval repeats:YES count:count delegate:nil delegateQueue:nil queueu:nil];
}


- (id<TimerProtocol>)timerWithInterval:(NSTimeInterval)interval repeats:(BOOL)repeats delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue
{
    return [[TimerProxy alloc] init:self.target withName:@"" interval:interval repeats:YES count:0 delegate:delegate delegateQueue:delegateQueue queueu:nil];
}

- (id<TimerProtocol>)timerWithInterval:(NSTimeInterval)interval count:(NSUInteger)count delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue
{
    return [[TimerProxy alloc] init:self.target withName:@"" interval:interval repeats:YES count:count delegate:delegate delegateQueue:delegateQueue queueu:nil];
}

- (id<TimerProtocol>)timerWithInterval:(NSTimeInterval)interval repeats:(BOOL)repeats queue:(dispatch_queue_t)queue
{
    return [[TimerProxy alloc] init:self.target withName:@"" interval:interval repeats:YES count:0 delegate:nil delegateQueue:nil queueu:queue];
}

- (id<TimerProtocol>)timerWithInterval:(NSTimeInterval)interval count:(NSUInteger)count queue:(dispatch_queue_t)queue
{
    return [[TimerProxy alloc] init:self.target withName:@"" interval:interval repeats:YES count:count delegate:nil delegateQueue:nil queueu:queue];
}

- (id<TimerProtocol>)timerWithName:(NSString*)name interval:(NSTimeInterval)interval repeats:(BOOL)repeats delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue
{
    return [[TimerProxy alloc] init:self.target withName:name interval:interval repeats:YES count:0 delegate:delegate delegateQueue:delegateQueue queueu:nil];
}

- (id<TimerProtocol>)timerWithName:(NSString*)name interval:(NSTimeInterval)interval count:(NSUInteger)count delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue
{
    return [[TimerProxy alloc] init:self.target withName:name interval:interval repeats:YES count:count delegate:delegate delegateQueue:delegateQueue queueu:nil];
}

- (id<TimerProtocol>)timerWithName:(NSString*)name interval:(NSTimeInterval)interval repeats:(BOOL)repeats queue:(dispatch_queue_t)queue
{
     return [[TimerProxy alloc] init:self.target withName:name interval:interval repeats:YES count:0 delegate:nil delegateQueue:nil queueu:queue];
}

- (id<TimerProtocol>)timerWithName:(NSString*)name interval:(NSTimeInterval)interval count:(NSUInteger)count queue:(dispatch_queue_t)queue
{
     return [[TimerProxy alloc] init:self.target withName:name interval:interval repeats:YES count:count delegate:nil delegateQueue:nil queueu:queue];
}

- (id<TimerProtocol>)timerWithDelegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue queue:(dispatch_queue_t)queue
{
    return [[TimerProxy alloc] init:self.target withName:@"" interval:1.0 repeats:YES count:0 delegate:delegate delegateQueue:delegateQueue queueu:queue];
}

- (id<TimerProtocol>)timerWithInterval:(NSTimeInterval)interval delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue queue:(dispatch_queue_t)queue
{
    return [[TimerProxy alloc] init:self.target withName:@"" interval:interval repeats:YES count:0 delegate:delegate delegateQueue:delegateQueue queueu:queue];
}

- (id<TimerProtocol>)timerWithInterval:(NSTimeInterval)interval repeats:(BOOL)repeats delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue queue:(dispatch_queue_t)queue
{
    return [[TimerProxy alloc] init:self.target withName:@"" interval:interval repeats:YES count:0 delegate:delegate delegateQueue:delegateQueue queueu:queue];
}

- (id<TimerProtocol>)timerWithInterval:(NSTimeInterval)interval count:(NSInteger)count delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue queue:(dispatch_queue_t)queue
{
    return [[TimerProxy alloc] init:self.target withName:@"" interval:interval repeats:YES count:0 delegate:delegate delegateQueue:delegateQueue queueu:queue];
}

- (id<TimerProtocol>)timerWithName:(NSString*)name interval:(NSTimeInterval)interval count:(NSInteger)count delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue queue:(dispatch_queue_t)queue
{
     return [[TimerProxy alloc] init:self.target withName:name interval:interval repeats:YES count:count delegate:delegate delegateQueue:delegateQueue queueu:queue];
}

- (id<TimerProtocol>)timerWithName:(NSString*)name interval:(NSTimeInterval)interval repeats:(BOOL)repeats delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue queue:(dispatch_queue_t)queue
{
      return [[TimerProxy alloc] init:self.target withName:name interval:interval repeats:YES count:0 delegate:delegate delegateQueue:delegateQueue queueu:queue];
}


///////////////////----------AutoTimer-----------------\\\\\\\\\\\\\\\\\\\\\\

- (id<TimerProtocol>)autoTimerNow:(BOOL)now
{
    return [[AutoTimerProxy alloc] init:self.target withName:@"" interval:1.0 repeats:YES count:0 delegate:nil delegateQueue:nil queueu:nil now:(BOOL)now];
}

- (id<TimerProtocol>)autoTimerWithName:(NSString*)name now:(BOOL)now
{
    return [[AutoTimerProxy alloc] init:self.target withName:name interval:1.0 repeats:YES count:0 delegate:nil delegateQueue:nil queueu:nil now:(BOOL)now];
}

- (id<TimerProtocol>)autoTimerWithInterval:(NSTimeInterval)interval now:(BOOL)now
{
    return [[AutoTimerProxy alloc] init:self.target withName:@"" interval:interval repeats:YES count:0 delegate:nil delegateQueue:nil queueu:nil now:(BOOL)now];
}

- (id<TimerProtocol>)autoTimerWithInterval:(NSTimeInterval)interval repeats:(BOOL)repeats now:(BOOL)now
{
    return [[AutoTimerProxy alloc] init:self.target withName:@"" interval:interval repeats:repeats count:0 delegate:nil delegateQueue:nil queueu:nil now:(BOOL)now];
}

- (id<TimerProtocol>)autoTimerWithInterval:(NSTimeInterval)interval count:(NSUInteger)count now:(BOOL)now
{
    return [[AutoTimerProxy alloc] init:self.target withName:@"" interval:interval repeats:YES count:count delegate:nil delegateQueue:nil queueu:nil now:(BOOL)now];
}

- (id<TimerProtocol>)autoTimerWithName:(NSString*)name interval:(NSTimeInterval)interval now:(BOOL)now
{
    return [[AutoTimerProxy alloc] init:self.target withName:name interval:interval repeats:YES count:0 delegate:nil delegateQueue:nil queueu:nil now:(BOOL)now];
}

- (id<TimerProtocol>)autoTimerWithName:(NSString*)name interval:(NSTimeInterval)interval repeats:(BOOL)repeats now:(BOOL)now
{
    return [[AutoTimerProxy alloc] init:self.target withName:name interval:interval repeats:repeats count:0 delegate:nil delegateQueue:nil queueu:nil now:(BOOL)now];
}

- (id<TimerProtocol>)autoTimerWithName:(NSString*)name interval:(NSTimeInterval)interval count:(NSUInteger)count now:(BOOL)now
{
    return [[AutoTimerProxy alloc] init:self.target withName:name interval:interval repeats:YES count:count delegate:nil delegateQueue:nil queueu:nil now:(BOOL)now];
}


- (id<TimerProtocol>)autoTimerWithInterval:(NSTimeInterval)interval repeats:(BOOL)repeats delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue now:(BOOL)now
{
    return [[AutoTimerProxy alloc] init:self.target withName:@"" interval:interval repeats:YES count:0 delegate:delegate delegateQueue:delegateQueue queueu:nil now:(BOOL)now];
}

- (id<TimerProtocol>)autoTimerWithInterval:(NSTimeInterval)interval count:(NSUInteger)count delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue now:(BOOL)now
{
    return [[AutoTimerProxy alloc] init:self.target withName:@"" interval:interval repeats:YES count:count delegate:delegate delegateQueue:delegateQueue queueu:nil now:(BOOL)now];
}

- (id<TimerProtocol>)autoTimerWithInterval:(NSTimeInterval)interval repeats:(BOOL)repeats queue:(dispatch_queue_t)queue now:(BOOL)now
{
    return [[AutoTimerProxy alloc] init:self.target withName:@"" interval:interval repeats:YES count:0 delegate:nil delegateQueue:nil queueu:queue now:(BOOL)now];
}

- (id<TimerProtocol>)autoTimerWithInterval:(NSTimeInterval)interval count:(NSUInteger)count queue:(dispatch_queue_t)queue now:(BOOL)now
{
    return [[AutoTimerProxy alloc] init:self.target withName:@"" interval:interval repeats:YES count:count delegate:nil delegateQueue:nil queueu:queue now:(BOOL)now];
}

- (id<TimerProtocol>)autoTimerWithName:(NSString*)name interval:(NSTimeInterval)interval repeats:(BOOL)repeats delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue now:(BOOL)now
{
    return [[AutoTimerProxy alloc] init:self.target withName:name interval:interval repeats:YES count:0 delegate:delegate delegateQueue:delegateQueue queueu:nil now:(BOOL)now];
}

- (id<TimerProtocol>)autoTimerWithName:(NSString*)name interval:(NSTimeInterval)interval count:(NSUInteger)count delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue now:(BOOL)now
{
    return [[AutoTimerProxy alloc] init:self.target withName:name interval:interval repeats:YES count:count delegate:delegate delegateQueue:delegateQueue queueu:nil now:(BOOL)now];
}

- (id<TimerProtocol>)autoTimerWithName:(NSString*)name interval:(NSTimeInterval)interval repeats:(BOOL)repeats queue:(dispatch_queue_t)queue now:(BOOL)now
{
    return [[AutoTimerProxy alloc] init:self.target withName:name interval:interval repeats:YES count:0 delegate:nil delegateQueue:nil queueu:queue now:(BOOL)now];
}

- (id<TimerProtocol>)autoTimerWithName:(NSString*)name interval:(NSTimeInterval)interval count:(NSUInteger)count queue:(dispatch_queue_t)queue now:(BOOL)now
{
    return [[AutoTimerProxy alloc] init:self.target withName:name interval:interval repeats:YES count:count delegate:nil delegateQueue:nil queueu:queue now:(BOOL)now];
}

- (id<TimerProtocol>)autoTimerWithDelegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue queue:(dispatch_queue_t)queue now:(BOOL)now
{
    return [[AutoTimerProxy alloc] init:self.target withName:@"" interval:1.0 repeats:YES count:0 delegate:delegate delegateQueue:delegateQueue queueu:queue now:(BOOL)now];
}

- (id<TimerProtocol>)autoTimerWithInterval:(NSTimeInterval)interval delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue queue:(dispatch_queue_t)queue now:(BOOL)now
{
    return [[AutoTimerProxy alloc] init:self.target withName:@"" interval:interval repeats:YES count:0 delegate:delegate delegateQueue:delegateQueue queueu:queue now:(BOOL)now];
}

- (id<TimerProtocol>)autoTimerWithInterval:(NSTimeInterval)interval repeats:(BOOL)repeats delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue queue:(dispatch_queue_t)queue now:(BOOL)now
{
    return [[AutoTimerProxy alloc] init:self.target withName:@"" interval:interval repeats:YES count:0 delegate:delegate delegateQueue:delegateQueue queueu:queue now:(BOOL)now];
}

- (id<TimerProtocol>)autoTimerWithInterval:(NSTimeInterval)interval count:(NSInteger)count delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue queue:(dispatch_queue_t)queue now:(BOOL)now
{
    return [[AutoTimerProxy alloc] init:self.target withName:@"" interval:interval repeats:YES count:0 delegate:delegate delegateQueue:delegateQueue queueu:queue now:(BOOL)now];
}

- (id<TimerProtocol>)autoTimerWithName:(NSString*)name interval:(NSTimeInterval)interval count:(NSInteger)count delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue queue:(dispatch_queue_t)queue now:(BOOL)now
{
    return [[AutoTimerProxy alloc] init:self.target withName:name interval:interval repeats:YES count:count delegate:delegate delegateQueue:delegateQueue queueu:queue now:(BOOL)now];
}

- (id<TimerProtocol>)autoTimerWithName:(NSString*)name interval:(NSTimeInterval)interval repeats:(BOOL)repeats delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue queue:(dispatch_queue_t)queue now:(BOOL)now
{
    return [[AutoTimerProxy alloc] init:self.target withName:name interval:interval repeats:YES count:0 delegate:delegate delegateQueue:delegateQueue queueu:queue now:(BOOL)now];
}

@end

@implementation TimerProxy
@synthesize autoDestroy;
@synthesize timer = _timer;

- (instancetype)init:(id)target withName:(NSString*)name interval:(NSTimeInterval)interval repeats:(BOOL)repeats count:(NSUInteger)count delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue queueu:(dispatch_queue_t)timerQueue
{
    _target = target;
    _name = [name copy];
    _interval = interval;
    _repeats = repeats;
    _totoalCount = count;
    _delegate = delegate;
    _delegateQueue = delegateQueue;
    _timerQueue = timerQueue;
    self.autoDestroy = YES;
    
    if(_delegate == nil)
        _delegate = _target; //target is a default delegate
    
    return self;
}

- (NSMethodSignature*)methodSignatureForSelector:(SEL)sel
{
    return [_target methodSignatureForSelector:sel];
}

- (void) forwardInvocation:(NSInvocation *)invocation
{
    invocation.target = _target;
    self.invocation = invocation;
}

- (NSString*)name
{
    return _name;
}

- (id)target
{
    return _target;
}

- (void)start
{
    [self start:NO];
}

- (void)start:(BOOL)now
{
    if(_timer || self.invocation == nil || self.invocation.target == nil)
        return; //already active
    
    if(_manager == nil)
    {
        _manager = getManagerForTimer(self);
    }
    
    if(_manager == nil)
    {
       _timer = [NSTimer timerWithTimeInterval:_interval target:self selector:@selector(invoke) userInfo:nil repeats:_totoalCount == 0 ? _repeats : YES];
    }
    else
    {
        _timer = [_manager createTimerWithInterval:_interval target:self selector:@selector(invoke) repeats:_totoalCount == 0 ? _repeats : YES];
    }
    
    _iterationsDone = 0;
    
    if(now)
    {
        if (_manager== nil)
        {
            [self invoke];
        }
        else
        {
            [_manager makeCall:self.invocation];
        }
    }
    
    if(_manager)
    {
        [_manager addTimer:self];
        [_manager startTimer:self];
    }
    else
    {
        [NSRunLoop.currentRunLoop  addTimer:(NSTimer*)_timer forMode:NSDefaultRunLoopMode];
    }
    
    if(_delegate && [_delegate respondsToSelector:@selector(timerStarted:)])
    {
       if(_delegateQueue)
       {
           __weak TimerProxy *weakSelf = self;
           dispatch_async(_delegateQueue, ^
           {
               [_delegate timerStarted:weakSelf];
           });
       }
       else
       {
          [_delegate timerStarted:self];
       }
    }
}

- (void)invalidate
{
    if(_timer)
    {
        if(_manager)
        {
            [_manager stopTimer:self];
        }
        else
        {
           [_timer invalidate];
        }
        if(_delegate && [_delegate respondsToSelector:@selector(timerInvalidated:)])
        {
            if(_delegateQueue)
            {
                __weak TimerProxy *weakSelf = self;
                dispatch_async(_delegateQueue, ^
                {
                    [_delegate timerInvalidated:weakSelf];
                });
            }
            else
            {
                [_delegate timerInvalidated:self];
            }
        }
    }
    _timer = nil;
}

- (void) dealloc
{
    [self destroy];
}

- (void)destroy
{
    [self invalidate];
    [_manager removeTimer:self];
    [self freeTarget]; //just in case we had it strong
    if(_delegate && [_delegate respondsToSelector:@selector(timerDestroyed:)])
    {
        NSString *timerName = _name;
        if(_delegateQueue)
        {
            dispatch_async(_delegateQueue, ^
            {
                [_delegate timerDestroyed:timerName];
            });
        }
        else
        {
            [_delegate timerDestroyed:timerName];
        }
    }
}

- (void)restart:(BOOL)now
{
    if(_timer)
    {
        [self invalidate];
    }
    [self start:now];
}

- (void)restart
{
    [self restart:NO];
}

- (void)subInvoke
{
    [self.invocation invoke];
    
    __weak TimerProxy *weakSelf = self;
    __weak NSInvocation *weakInvocation = self.invocation;
    if(_delegate && [_delegate respondsToSelector:@selector(timer:tickedWithInvocation:)])
    {
        if(_delegateQueue)
        {
            dispatch_async(_delegateQueue, ^
            {
                [_delegate timer:weakSelf tickedWithInvocation:weakInvocation];
            });
        }
        else
        {
            [_delegate timer:weakSelf tickedWithInvocation:weakInvocation];
        }
    }
    
    if ((_iterationsDone == _totoalCount && _totoalCount != 0) || _repeats == NO) //timer finished
    {
        if(self.autoDestroy)
        {
            [self destroy];
        }
        else
        {
            [self invalidate];
        }
    }
}

- (void)invoke
{
    if (_target == nil)
    {
        [self destroy];
        return;
    }
    
    _iterationsDone++;
    if(_timerQueue)
    {
       __weak TimerProxy *weakSelf = self;
       dispatch_async(_timerQueue, ^
       {
           [weakSelf subInvoke];
       });
    }
    else
    {
       [self subInvoke];
    }
}

- (void) stronglefyTarget
{
    _strongTarget = _target;
}

-(void) freeTarget
{
    _strongTarget = nil;
}

@end

@implementation AutoTimerProxy

- (instancetype)init:(id)target withName:(NSString*)name interval:(NSTimeInterval)interval repeats:(BOOL)repeats count:(NSUInteger)count delegate:(id<TmerProxyDelegate>)delegate delegateQueue:(dispatch_queue_t)delegateQueue queueu:(dispatch_queue_t)timerQueue now:(BOOL)now
{
    self = [super init:target withName:name interval:interval repeats:repeats count:count delegate:delegate delegateQueue:delegateQueue queueu:timerQueue];
    if(self)
    {
        _now = now;
    }
    return self;
}

- (void) forwardInvocation:(NSInvocation *)invocation
{
    invocation.target = _target;
    self.invocation = invocation;
    [self start:_now];
}

@end
