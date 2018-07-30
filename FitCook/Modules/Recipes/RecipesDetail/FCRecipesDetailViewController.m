//
//  FCRecipesDetailViewController.m
//  FitCook
//
//  Created by Joyoki on 2018/7/31.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCRecipesDetailViewController.h"

@interface FCRecipesDetailViewController ()

@end

@implementation FCRecipesDetailViewController

+ (NSString *)storyboardName {
    return @"Recipes";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Override
- (BOOL)needsHiddenNavigationBar {
    return YES;
}

@end
