//
//  FCRootViewController.m
//  FitCook
//
//  Created by Joyoki on 2018/7/17.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCRootViewController.h"
#import "FCMainViewController.h"
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

- (void)showMainViewController:(BOOL)animated {
    FCMainViewController *vcMain = [[FCMainViewController alloc] init];
    vcMain.view.frame = self.view.bounds;
    [self addChildViewController:vcMain];
    if (animated) {
        [self.view insertSubview:vcMain.view belowSubview:_vcShowing.view];
        [UIView animateWithDuration:0.4 animations:^{
            self.vcShowing.view.transform = CGAffineTransformMakeScale(1.1, 1.1);
        } completion:^(BOOL finished) {
            
        }];
        [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.vcShowing.view.alpha = 0;
        } completion:^(BOOL finished) {
            [self.vcShowing.view removeFromSuperview];
            [self.vcShowing removeFromParentViewController];
            self.vcShowing = vcMain;
        }];
    } else {
        [self.view addSubview:vcMain.view];
        self.vcShowing = vcMain;
    }
}

- (void)showLoginViewController:(BOOL)animated {
    FCSignInViewController *vcSignIn = [FCSignInViewController viewControllerFromStoryboard];
    FCNavigationController *navSignIn = [[FCNavigationController alloc] initWithRootViewController:vcSignIn];
    if (animated) {
        navSignIn.view.frame = CGRectMake(0, self.view.height, self.view.width, self.view.height);
        [self addChildViewController:navSignIn];
        [self.view addSubview:navSignIn.view];
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            navSignIn.view.frame = self.view.bounds;
        } completion:^(BOOL finished) {
            [self.vcShowing.view removeFromSuperview];
            [self.vcShowing removeFromParentViewController];
            self.vcShowing = navSignIn;
        }];
    } else {
        navSignIn.view.frame = self.view.bounds;
        [self addChildViewController:navSignIn];
        [self.view addSubview:navSignIn.view];
        self.vcShowing = navSignIn;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return _vcShowing;
}

- (void)signInNotification:(NSNotification *)noti {
    [self showMainViewController:YES];
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
