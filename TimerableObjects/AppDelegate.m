//
//  AppDelegate.m
//  TimerableObjects
//
//  Created by Sergey Makeev on 02/04/2017.
//  Copyright © 2017 SOME projects. All rights reserved.
//

#import "AppDelegate.h"
#import "SomeTimerThread.h"
#import "TimerableProxy.h"

static SomeTimerThread *timerThread;

id<ManagerForTimerProtocol> getManagerForTimer(id<TimerProtocol> timer)
{
    if(timerThread == nil)
    {
        timerThread = [[SomeTimerThread alloc] init];
    }
    
    //Here you can return nil. Ths will mean to use current run loop.
    //You can use timer.name to detect what timer should be returned
    
    return timerThread;
}

@interface AppDelegate ()

@end

@implementation AppDelegate


- (void)sleepAwaikTimer
{
    if(![timerThread stopped])
    {
       if([timerThread sleeping])
       {
           [timerThread awaik];
       }
       else
       {
          [timerThread suspend];
       }
    }
}


- (void)startStopTimer
{
    if([timerThread stopped])
    {
        [timerThread start];
        AppDelegate *tmp = self;
        MAKE_TIMERABLE(tmp)
        TIMER(AppDelegate) valueTimer = (TIMER(AppDelegate))[(TIMERABLE(AppDelegate))tmp timerWithInterval:1.0];
        [valueTimer printExample];
        [valueTimer start];
    }
    else
    {
        [timerThread stop];
    }
}

- (void) printExample
{
    NSLog(@"Timer in thread manager");
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    if(!timerThread)
    {
        [(SomeTimerThread*)getManagerForTimer(nil) start];
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
