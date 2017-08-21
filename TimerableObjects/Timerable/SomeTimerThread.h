//
//  SomeTimerThread.h
//  TimerableObjects
//
//  Created by Sergey Makeev on 02/04/2017.
//  Copyright © 2017 SOME projects. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimerableProxy.h"
#import "ManagerForTimerProtocol.h"

@import Darwin.os.lock;

@protocol TimerThreadLocker <NSObject>
@required
- (void)lock;
- (void)unlock;
@end

@interface SomeTimerThread : NSObject <ManagerForTimerProtocol, TimerThreadLocker>

- (BOOL)stopped;
- (BOOL)sleeping;
- (void)start;
- (void)stop;
- (void)awaik;
- (void)suspend;

@end
