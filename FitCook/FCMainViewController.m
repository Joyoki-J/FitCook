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
    
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabBar_bg"]];
    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tabBar_shadow"]];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName: kFCFont_10,NSForegroundColorAttributeName : COLOR_TAB_BAR_ITEM_TITLE}
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName: kFCFont_10, NSForegroundColorAttributeName : COLOR_TAB_BAR_ITEM_TITLE_SELECTED}
                                             forState:UIControlStateSelected];
    
    FCBaseViewController *vc1 = [[FCBaseViewController alloc] init];
    vc1.title = @"Recipes";
    UINavigationController *navBarC1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    navBarC1.tabBarItem = [self tabBarItemWithTitle:@"Recipes" imageName:@"tabbar_recipes_normal" selectedImageName:@"tabbar_recipes_selected"];
    
    FCBaseViewController *vc2 = [[FCBaseViewController alloc] init];
    vc2.title = @"Shopping";
    UINavigationController *navBarC2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    navBarC2.tabBarItem = [self tabBarItemWithTitle:@"Shopping" imageName:@"tabbar_shopping_normal" selectedImageName:@"tabbar_shopping_selected"];
    
    FCBaseViewController *vc3 = [[FCBaseViewController alloc] init];
    vc3.title = @"Search";
    UINavigationController *navBarC3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    navBarC3.tabBarItem = [self tabBarItemWithTitle:@"Search" imageName:@"tabbar_search_normal" selectedImageName:@"tabbar_search_selected"];
   
    FCBaseViewController *vc4 = [[FCBaseViewController alloc] init];
    vc4.title = @"Favourites";
    UINavigationController *navBarC4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    navBarC4.tabBarItem = [self tabBarItemWithTitle:@"Favourites" imageName:@"tabbar_favourites_normal" selectedImageName:@"tabbar_favourites_selected"];
    
    FCBaseViewController *vc5 = [[FCBaseViewController alloc] init];
    vc5.title = @"Profile";
    UINavigationController *navBarC5 = [[UINavigationController alloc] initWithRootViewController:vc5];
    navBarC5.tabBarItem = [self tabBarItemWithTitle:@"Profile" imageName:@"tabbar_profile_normal" selectedImageName:@"tabbar_profile_selected"];
    
    self.viewControllers = @[navBarC1, navBarC2, navBarC3, navBarC4, navBarC5];
    
    [self setSelectedIndex:2];
}

- (UITabBarItem *)tabBarItemWithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:image tag:0];
    [item setSelectedImage:selectedImage];
    item.titlePositionAdjustment = UIOffsetMake(0, -3);
    return item;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
