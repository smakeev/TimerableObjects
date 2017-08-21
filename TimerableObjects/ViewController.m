//
//  ViewController.m
//  TimerableObjects
//
//  Created by Sergey Makeev on 02/04/2017.
//  Copyright © 2017 SOME projects. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "TimerableProxy.h"

@interface UILabel (TIMERABLE) <TmerProxyDelegate>
@end

@implementation UILabel (TIMERABLE)

- (void) timerStarted:(id<TimerProtocol>)timer
{
    NSLog(@"Timer with name %@ started", timer.name);
}

- (void) timerInvalidated:(id<TimerProtocol>)timer
{
    NSLog(@"Timer with name %@ invalidated", timer.name);
}

- (void) timerDestroyed:(NSString*)timerName
{
    NSLog(@"Timer with name %@ destroyed", timerName);
}

- (void) timer:(id<TimerProtocol>)timer tickedWithInvocation:(NSInvocation*)invocation
{
   NSLog(@"Timer with name %@ tickedWithResult", timer.name);
   if([timer.name isEqualToString:@"TEXT_READER"])
   {
       
       //Try to take value
       NSString * __unsafe_unretained tempResultString;
       [invocation getReturnValue:&tempResultString];
       NSString *result = tempResultString;
       NSLog(@"!!!!! current result: %@", result);

   }
    
    
  //  void *ret;
  //  [_invocation getReturnValue:ret];
    
}

@end

@interface ViewController ()
{
    UILabel *testLabel;
    
    NSInteger value;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    testLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 49, 200, 200)];
    testLabel.text = @"-1";
    [self.view addSubview:testLabel];
    
    ///VAriant 1. Using timer ref and calling start.
    
    MAKE_TIMERABLE(testLabel)
    testLabel.text = @"0"; //without timing

    TIMER(UILabel) t = (TIMER(UILabel))[(TIMERABLE(UILabel))testLabel timerWithName:@"TEXT_WRITER" interval:10.5 repeats:YES queue:dispatch_get_main_queue()];
    t.text = @"Text from timer"; //this will be cvalled in timer
    [t start:YES];

    TIMER(UILabel) t1 = (TIMER(UILabel))[(TIMERABLE(UILabel))testLabel timerWithName:@"TEXT_READER" interval:0.5 repeats:YES queue:dispatch_get_main_queue()];
    [t1 text]; //this will be called in timer
    [t1 start];
    [t invalidate];
    ViewController *tmp = self;
    MAKE_TIMERABLE(tmp)
    TIMER(ViewController) valueTimer = (TIMER(ViewController))[(TIMERABLE(ViewController))tmp timerWithInterval:1.0];
    [valueTimer changeValueOn:3];
    [valueTimer start];
    
    //Variant 2 auto start
    [(TIMER(ViewController))[(TIMERABLE(ViewController))tmp autoTimerWithInterval:5 count:10 now:YES] setRandomBAckground];
}

- (NSInteger)changeValueOn:(NSInteger)step
{
    value += step;
    dispatch_async(dispatch_get_main_queue(), ^
    {
       testLabel.text = [NSString stringWithFormat:@"%ld", value];
    });
    return value;
}

- (void) setRandomBAckground
{
    CGFloat hue = ( arc4random_uniform(256) / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random_uniform(128) / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random_uniform(128) / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    dispatch_async(dispatch_get_main_queue(), ^
    {
       self.view.backgroundColor = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    });
}
- (IBAction)pressed:(id)sender
{
    AppDelegate* delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    [delegate sleepAwaikTimer];
}
- (IBAction)pressedStopStart:(id)sender
{
    
    AppDelegate* delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    [delegate startStopTimer];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
