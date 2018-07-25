//
//  FCRootViewController.m
//  FitCook
//
//  Created by Joyoki on 2018/7/17.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCRootViewController.h"
#import "FCMainViewController.h"
#import "FCLaunchViewController.h"

@interface FCRootViewController ()

@property (nonatomic, strong) FCLaunchViewController *vcLaunch;
@property (nonatomic, strong) FCMainViewController *vcMain;

@end

@implementation FCRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FCMainViewController *vcMain = [[FCMainViewController alloc] init];
    vcMain.view.frame = self.view.bounds;
    [self addChildViewController:vcMain];
    [self.view addSubview:vcMain.view];
    _vcMain = vcMain;
    
    FCLaunchViewController *vcLaunch = [[FCLaunchViewController alloc] init];
    vcLaunch.view.frame = self.view.bounds;
    [self addChildViewController:vcLaunch];
    [self.view addSubview:vcLaunch.view];
    _vcLaunch = vcLaunch;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            vcLaunch.view.alpha = 0;
        } completion:^(BOOL finished) {
            if (finished) {
                [self.view sendSubviewToBack:vcLaunch.view];
                vcLaunch.view.alpha = 1;
            }
        }];
    });
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
