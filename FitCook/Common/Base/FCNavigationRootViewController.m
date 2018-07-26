//
//  FCNavigationRootViewController.m
//  FitCook
//
//  Created by Joyoki on 2018/7/26.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCNavigationRootViewController.h"

@interface FCNavigationRootViewController ()

@end

@implementation FCNavigationRootViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = NO;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.hidesBottomBarWhenPushed = NO;
    }
    
    return self;
}

- (BOOL)needsCustomBackBarButtonItem
{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kCOLOR_RANDOM;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
