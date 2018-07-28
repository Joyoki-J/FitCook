//
//  FCSearchRootViewController.m
//  FitCook
//
//  Created by Joyoki on 2018/7/26.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCSearchRootViewController.h"

@interface FCSearchRootViewController ()

@end

@implementation FCSearchRootViewController

+ (NSString *)storyboardName {
    return @"Search";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Override
- (BOOL)needsHiddenNavigationBar {
    return YES;
}

@end
