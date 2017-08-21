//
//  AppDelegate.h
//  TimerableObjects
//
//  Created by Sergey Makeev on 02/04/2017.
//  Copyright © 2017 SOME projects. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)sleepAwaikTimer;
- (void)startStopTimer;

@end

