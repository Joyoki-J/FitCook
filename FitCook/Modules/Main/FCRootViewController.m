//
//  FCRootViewController.m
//  FitCook
//
//  Created by shanshan on 2018/7/17.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCRootViewController.h"
#import "FCMainViewController.h"
#import "FCSignInViewController.h"
#import "FCNavigationController.h"

@interface FCRootViewController ()

@property (nonatomic, strong) UIViewController *vcSign;
@property (nonatomic, strong) UITabBarController *vcMain;

@end

@implementation FCRootViewController

+ (instancetype)shareViewController {
    return (FCRootViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signInNotification:) name:FCSignInNotificationKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutNotification:) name:FCLogoutNotificationKey object:nil];
    
    [self createMainViewController];
}

- (void)createMainViewController {
    FCMainViewController *vcMain = [[FCMainViewController alloc] init];
    _vcMain = vcMain;
    vcMain.view.frame = self.view.bounds;
    [self.view addSubview:vcMain.view];
    [self addChildViewController:vcMain];
}

- (void)showLoginViewController {
    if (!self.isShowSign) {
        FCSignInViewController *vcSignIn = [FCSignInViewController viewControllerFromStoryboard];
        FCNavigationController *navSignIn = [[FCNavigationController alloc] initWithRootViewController:vcSignIn];
        navSignIn.view.frame = CGRectMake(0, self.view.height, self.view.width, self.view.height);
        [self.view addSubview:navSignIn.view];
        [self addChildViewController:navSignIn];
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            navSignIn.view.frame = self.view.bounds;
        } completion:^(BOOL finished) {
            self.vcSign = navSignIn;
        }];
    }
}

- (void)hideLoginViewController {
    if (self.isShowSign) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.vcSign.view.frame = CGRectMake(0, self.view.height, self.view.width, self.view.height);
        } completion:^(BOOL finished) {
            [self.vcSign.view removeFromSuperview];
            [self.vcSign removeFromParentViewController];
            self.vcSign = nil;
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (BOOL)isShowSign {
    return _vcSign != nil;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return _vcSign ? _vcSign : _vcMain;
}

- (void)signInNotification:(NSNotification *)noti {
    [self hideLoginViewController];
}

- (void)logoutNotification:(NSNotification *)noti {
    [self.vcMain setSelectedIndex:2];
}

#pragma mark - setter&getter
- (void)setVcSign:(UIViewController *)vcSign {
    _vcSign = vcSign;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
