//
//  ManagerForTimerProtocol.h
//  TimerableObjects
//
//  Created by Sergey Makeev on 14/04/2017.
//  Copyright © 2017 SOME projects. All rights reserved.
//

#ifndef ManagerForTimerProtocol_h
#define ManagerForTimerProtocol_h

@protocol ManagerForTimerProtocol <NSObject>
@required
- (void)addTimer:(id<TimerForManager>)timer;
- (void)startTimer:(id<TimerForManager>)timer;
- (void)stopTimer:(id<TimerForManager>)timer;
- (void)removeTimer:(id<TimerForManager>)timer;
- (void)makeCall:(NSInvocation*)invocation;
- (id) createTimerWithInterval:(NSTimeInterval)interval target:(id) target selector:(SEL) selector  repeats:(BOOL) repeats;


@end

#endif /* ManagerForTimerProtocol_h */
