//
//  FCNavigationRootViewController.m
//  FitCook
//
//  Created by shanshan on 2018/7/26.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCNavigationRootViewController.h"

@interface FCNavigationRootViewController ()

@end

@implementation FCNavigationRootViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.hidesBottomBarWhenPushed = NO;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = NO;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Override
- (BOOL)needsCustomBackBarButtonItem
{
    return NO;
}

- (UIFont *)navigationBarTitleFont {
    return kFont(25);
}

@end
