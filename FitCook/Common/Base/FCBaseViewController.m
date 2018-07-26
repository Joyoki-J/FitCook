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

- (UIImage *)navigationBarBackgroundImage {
    return [UIImage fc_imageWithColor:[UIColor whiteColor]];
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
