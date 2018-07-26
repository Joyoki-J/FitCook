//
//  FCNavigationController.m
//  FitCook
//
//  Created by Joyoki on 2018/7/26.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCNavigationController.h"

@interface FCNavigationController ()

@end

@implementation FCNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationBar.translucent = NO;
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.topViewController) {
        return [self.topViewController preferredStatusBarStyle];
    }
    return UIStatusBarStyleDefault;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
