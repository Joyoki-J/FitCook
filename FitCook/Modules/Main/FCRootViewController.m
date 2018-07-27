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

@property (nonatomic, strong) UIViewController *vcShowing;

@end

@implementation FCRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showMainViewController];
}

- (void)showLaunchViewController {
    FCLaunchViewController *vcLaunch = [[FCLaunchViewController alloc] init];
    [self showSubViewController:vcLaunch];
}

- (void)showMainViewController {
    FCMainViewController *vcMain = [[FCMainViewController alloc] init];
    [self showSubViewController:vcMain];
}

- (void)showSubViewController:(UIViewController *)subVC {
    subVC.view.frame = self.view.bounds;
    [self addChildViewController:subVC];
    if (_vcShowing) {
        [self.view insertSubview:subVC.view belowSubview:_vcShowing.view];
        [UIView animateWithDuration:0.3 animations:^{
            self.vcShowing.view.alpha = 0;
        } completion:^(BOOL finished) {
            [self.vcShowing.view removeFromSuperview];
            [self.vcShowing removeFromParentViewController];
            self.vcShowing = subVC;
        }];
    } else {
        [self.view addSubview:subVC.view];
        self.vcShowing = subVC;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return _vcShowing;
}

#pragma mark - setter&getter
- (void)setVcShowing:(UIViewController *)vcShowing {
    _vcShowing = vcShowing;
    [self setNeedsStatusBarAppearanceUpdate];
}



@end
