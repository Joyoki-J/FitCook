//
//  FCBaseViewController.m
//  FitCook
//
//  Created by Jay on 2018/7/16.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCBaseViewController.h"
#import "UIBarButtonItem+FC.h"
#import "UIImage+FC.h"

@interface FCBaseViewController ()

@property (nonatomic, strong) UIBarButtonItem *customBarButtonItem;

@end

@implementation FCBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = NO;
    
    [self addCustomBackBarButtonItemIfNeeded];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[self navigationBarBackgroundImage] forBarMetrics:UIBarMetricsDefault];
    
    NSMutableDictionary *titleAttributes = [NSMutableDictionary dictionary];
    UIColor *titleColor = self.navigationController.navigationBar.titleTextAttributes[NSForegroundColorAttributeName];
    if (![titleColor isEqual:[self navigationBarTitleColor]]) {
        [titleAttributes setObject:[self navigationBarTitleColor] forKey:NSForegroundColorAttributeName];
    }
    UIColor *titleFont  = self.navigationController.navigationBar.titleTextAttributes[NSFontAttributeName];
    if (![titleFont isEqual:[self navigationBarTitleFont]]) {
        [titleAttributes setObject:[self navigationBarTitleFont] forKey:NSFontAttributeName];
    }
    if (titleAttributes.allKeys.count > 0) {
        NSMutableDictionary *attributes = [self.navigationController.navigationBar.titleTextAttributes mutableCopy];
        if (attributes) {
            [titleAttributes enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [attributes setObject:obj forKey:key];
            }];
            [self.navigationController.navigationBar setTitleTextAttributes:attributes];
        } else {
            [self.navigationController.navigationBar setTitleTextAttributes:titleAttributes];
        }
    }
    
    if (self.isViewWillAppearBecauseOfPop) {
        [self.navigationController setNavigationBarHidden:[self needsHiddenNavigationBar] animated:YES];
    } else {
        //from tab bar
        [self.navigationController setNavigationBarHidden:[self needsHiddenNavigationBar] animated:NO];
    }
}

- (void)addCustomBackBarButtonItemIfNeeded
{
    if ([self needsCustomBackBarButtonItem]) {
        if ([self customLeftBarButtonItems] && [self customLeftBarButtonItems].count > 0) {
            NSMutableArray *items = [NSMutableArray arrayWithObject:self.customBarButtonItem];
            [items addObjectsFromArray:[self customLeftBarButtonItems]];
            self.navigationItem.leftBarButtonItems = items;
        } else {
            if (self.navigationItem.leftBarButtonItem != self.customBarButtonItem) {
                self.navigationItem.leftBarButtonItem = self.customBarButtonItem;
            }
        }
    }
}

- (BOOL)needsHiddenNavigationBar
{
    return NO;
}

- (BOOL)needsCustomBackBarButtonItem
{
    return YES;
}

- (NSArray *)customLeftBarButtonItems
{
    return nil;
}

- (UIImage *)navigationBarBackgroundImage {
    return [UIImage fc_imageWithColor:[UIColor whiteColor]];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (UIColor *)navigationBarTitleColor {
    return [UIColor blackColor];
}

- (UIFont *)navigationBarTitleFont {
    return [UIFont systemFontOfSize:20];
}

- (UIBarButtonItem *)customBarButtonItem
{
    if (!_customBarButtonItem) {
        _customBarButtonItem = [self backButtonItem];
    }
    return _customBarButtonItem;
}

- (UIBarButtonItem *)backButtonItem
{
    return [self backButtonItemWithImageName:@"navBarItem_back" highlightedImageName:@"navBarItem_back_highlighted"];
}


- (UIBarButtonItem *)backButtonItemWithImageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName
{
    return [UIBarButtonItem fc_backBarButtonItemWithTarget:self
                                                 action:@selector(popViewController)
                                              imageName:imageName
                                   highlightedImageName:highlightedImageName
                                      selectedImageName:nil];
}

- (void)popViewController
{
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (BOOL)isViewWillAppearBecauseOfPop
{
    return [self.navigationController.view window] && !self.isMovingToParentViewController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
