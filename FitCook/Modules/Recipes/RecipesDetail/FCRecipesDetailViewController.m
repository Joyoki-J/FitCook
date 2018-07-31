//
//  FCRecipesDetailViewController.m
//  FitCook
//
//  Created by Joyoki on 2018/7/31.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCRecipesDetailViewController.h"

@interface FCRecipesDetailViewController ()

@property (nonatomic, strong) UIView *vNavBar;
@property (nonatomic, strong) UIButton *btnBack;

@end

@implementation FCRecipesDetailViewController

+ (NSString *)storyboardName {
    return @"Recipes";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    
    [self createSubViews];
    
    [self createCustomNavBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)createSubViews {
    
}

- (void)createCustomNavBar {
    UIView *vNavBar = [[UIView alloc] init];
    [self.view addSubview:vNavBar];
    [vNavBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(kNAVBAR_HEIGHT);
    }];
    
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBack setImage:[UIImage imageNamed:@"navbarItem_back_white"] forState:UIControlStateNormal];
    [btnBack setImage:[UIImage imageNamed:@"navbarItem_back_white"] forState:UIControlStateHighlighted];
    [btnBack addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    [vNavBar addSubview:btnBack];
    [btnBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(25);
        make.left.mas_equalTo(9);
        make.top.mas_equalTo(kSTATBAR_HEIGHT + (44.0 - 25.0) / 2.0);
    }];
};

#pragma mark - Override
- (BOOL)needsHiddenNavigationBar {
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
