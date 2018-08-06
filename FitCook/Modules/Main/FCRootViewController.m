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
#import "FCSignInViewController.h"
#import "FCNavigationController.h"

@interface FCRootViewController ()

@property (nonatomic, strong) UIViewController *vcShowing;

@end

@implementation FCRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signInNotification:) name:FCSignInNotificationKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutNotification:) name:FCLogoutNotificationKey object:nil];
    
    [self showLoginViewController:NO];
}

- (void)showLaunchViewController {
    FCLaunchViewController *vcLaunch = [[FCLaunchViewController alloc] init];
    [self showSubViewController:vcLaunch animated:NO];
}

- (void)showMainViewController {
    FCMainViewController *vcMain = [[FCMainViewController alloc] init];
    [self showSubViewController:vcMain animated:NO];
}

- (void)showLoginViewController:(BOOL)animated {
    FCSignInViewController *vcSignIn = [FCSignInViewController viewControllerFromStoryboard];
    FCNavigationController *navSignIn = [[FCNavigationController alloc] initWithRootViewController:vcSignIn];
    [self showSubViewController:navSignIn animated:animated];
}

- (void)showSubViewController:(UIViewController *)subVC animated:(BOOL)animated {
    if (_vcShowing) {
        if (animated) {
            subVC.view.frame = CGRectMake(0, self.view.height, self.view.width, self.view.height);
            [self addChildViewController:subVC];
            
            [self.view addSubview:subVC.view];
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                subVC.view.frame = self.view.bounds;
            } completion:^(BOOL finished) {
                [self.vcShowing.view removeFromSuperview];
                [self.vcShowing removeFromParentViewController];
                self.vcShowing = subVC;
            }];
        } else {
            subVC.view.frame = self.view.bounds;
            [self addChildViewController:subVC];
            
            [self.view insertSubview:subVC.view belowSubview:_vcShowing.view];
            [UIView animateWithDuration:0.3 animations:^{
                self.vcShowing.view.alpha = 0;
            } completion:^(BOOL finished) {
                [self.vcShowing.view removeFromSuperview];
                [self.vcShowing removeFromParentViewController];
                self.vcShowing = subVC;
            }];
        }
    } else {
        subVC.view.frame = self.view.bounds;
        [self addChildViewController:subVC];
        
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

- (void)signInNotification:(NSNotification *)noti {
    [self showMainViewController];
}

- (void)logoutNotification:(NSNotification *)noti {
    [self showLoginViewController:YES];
}

#pragma mark - setter&getter
- (void)setVcShowing:(UIViewController *)vcShowing {
    _vcShowing = vcShowing;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
