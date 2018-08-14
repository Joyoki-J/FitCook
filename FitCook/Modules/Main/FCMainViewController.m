//
//  FCMainViewController.m
//  FitCook
//
//  Created by shanshan on 2018/7/17.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCMainViewController.h"
#import "FCNavigationController.h"
#import "FCRecipesRootViewController.h"
#import "FCShoppingRootViewController.h"
#import "FCSearchRootViewController.h"
#import "FCFavouritesRootViewController.h"
#import "FCProfileRootViewController.h"

@interface FCMainViewController ()

@end

@implementation FCMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UITabBar appearance] setBackgroundImage:[UIImage fc_imageWithColor:[UIColor whiteColor]]];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName: kFont_10,NSForegroundColorAttributeName : kCOLOR_TAB_BAR_ITEM_TITLE}
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName: kFont_10, NSForegroundColorAttributeName : kCOLOR_TAB_BAR_ITEM_TITLE_SELECTED}
                                             forState:UIControlStateSelected];
    
    FCRecipesRootViewController *vcRecipes = [FCRecipesRootViewController viewControllerFromStoryboard];
    vcRecipes.title = @"Recipes";
    FCNavigationController *navcRecipes = [[FCNavigationController alloc] initWithRootViewController:vcRecipes];
    navcRecipes.tabBarItem = [self tabBarItemWithTitle:@"Recipes" imageName:@"tabbar_recipes_normal" selectedImageName:@"tabbar_recipes_selected"];
    
    FCShoppingRootViewController *vcShopping = [FCShoppingRootViewController viewControllerFromStoryboard];
    vcShopping.title = @"Shopping";
    FCNavigationController *navcShopping = [[FCNavigationController alloc] initWithRootViewController:vcShopping];
    navcShopping.tabBarItem = [self tabBarItemWithTitle:@"Shopping" imageName:@"tabbar_shopping_normal" selectedImageName:@"tabbar_shopping_selected"];
    
    FCSearchRootViewController *vcSearch = [FCSearchRootViewController viewControllerFromStoryboard];
    vcSearch.title = @"Search";
    FCNavigationController *navcSearch = [[FCNavigationController alloc] initWithRootViewController:vcSearch];
    navcSearch.tabBarItem = [self tabBarItemWithTitle:@"Search" imageName:@"tabbar_search_normal" selectedImageName:@"tabbar_search_selected"];
   
    FCFavouritesRootViewController *vcFavourites = [FCFavouritesRootViewController viewControllerFromStoryboard];
    vcFavourites.title = @"Favourites";
    FCNavigationController *navcFavourites = [[FCNavigationController alloc] initWithRootViewController:vcFavourites];
    navcFavourites.tabBarItem = [self tabBarItemWithTitle:@"Favourites" imageName:@"tabbar_favourites_normal" selectedImageName:@"tabbar_favourites_selected"];
    
    FCProfileRootViewController *vcProfile = [FCProfileRootViewController viewControllerFromStoryboard];
    vcProfile.title = @"Profile";
    FCNavigationController *navcProfile = [[FCNavigationController alloc] initWithRootViewController:vcProfile];
    navcProfile.tabBarItem = [self tabBarItemWithTitle:@"Profile" imageName:@"tabbar_profile_normal" selectedImageName:@"tabbar_profile_selected"];
    
    self.viewControllers = @[navcRecipes, navcShopping, navcSearch, navcFavourites, navcProfile];
    
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

- (void)dealloc
{
    NSLog(@"Main");
}

@end
