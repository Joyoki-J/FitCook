//
//  FCMainViewController.m
//  FitCook
//
//  Created by Joyoki on 2018/7/17.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCMainViewController.h"
#import "FCBaseViewController.h"

@interface FCMainViewController ()

@end

@implementation FCMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FCBaseViewController *vc1 = [[FCBaseViewController alloc] init];
    vc1.title = @"食谱";
    UINavigationController *navBarC1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    navBarC1.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:0];
    
    FCBaseViewController *vc2 = [[FCBaseViewController alloc] init];
    vc2.title = @"购物清单";
    UINavigationController *navBarC2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    navBarC2.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemRecents tag:1];
    
    FCBaseViewController *vc3 = [[FCBaseViewController alloc] init];
    vc3.title = @"搜索";
    UINavigationController *navBarC3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    navBarC3.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:2];
    
    FCBaseViewController *vc4 = [[FCBaseViewController alloc] init];
    vc4.title = @"收藏";
    UINavigationController *navBarC4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    navBarC4.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:3];
    
    FCBaseViewController *vc5 = [[FCBaseViewController alloc] init];
    vc5.title = @"我的";
    UINavigationController *navBarC5 = [[UINavigationController alloc] initWithRootViewController:vc5];
    navBarC5.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore tag:4];
    
    self.viewControllers = @[navBarC1, navBarC2, navBarC3, navBarC4, navBarC5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
