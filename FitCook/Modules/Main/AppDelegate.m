//
//  AppDelegate.m
//  FitCook
//
//  Created by Jay on 2018/7/16.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "AppDelegate.h"
#import "FCRootViewController.h"
#import "FCApp.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (instancetype)shareDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)setImageWithW:(NSString *)w dic:(NSMutableDictionary *)dic {
    NSString *key1 = [NSString stringWithFormat:@"%@_1",w];
    NSString *key2 = [NSString stringWithFormat:@"%@_2",w];
    NSString *key3 = [NSString stringWithFormat:@"%@_3",w];
    NSString *key4 = [NSString stringWithFormat:@"%@_4",w];
    [dic setObject:[self imageWithName:key1] forKey:key1];
    [dic setObject:[self imageWithName:key2] forKey:key2];
    [dic setObject:[self imageWithName:key3] forKey:key3];
    [dic setObject:[self imageWithName:key4] forKey:key4];
}

- (UIImage *)imageWithName:(NSString *)name {
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"png"]];
    CGRect rect = CGRectMake(0, 0, kSCREEN_WIDTH - 28, 134);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextFillRect(context, rect);
    [image drawInRect:rect];
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
 
    return im;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [FCApp initialized];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSArray<NSString *> *arrW = @[@"1",@"2",@"3",@"11",@"12",@"13",@"21",@"22",@"31",@"32",@"41",@"42"];
    [arrW enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self setImageWithW:obj dic:dic];
    }];
    _images = dic;
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    FCRootViewController *vcRoot = [[FCRootViewController alloc] init];
    self.window.rootViewController = vcRoot;
    [self.window makeKeyAndVisible];
    
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
