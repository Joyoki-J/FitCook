//
//  FCSignUpViewController.m
//  FitCook
//
//  Created by Joyoki on 2018/8/6.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCSignUpViewController.h"

@interface FCSignUpViewController ()

@end

@implementation FCSignUpViewController

+ (NSString *)storyboardName {
    return @"Login";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickSignUpAction:(UIButton *)sender {
    NSLog(@"点击 - SignUp");
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)onClickSignInAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Override

- (BOOL)needsHiddenNavigationBar {
    return YES;
}

- (BOOL)canDragBackFromNavigationController {
    return NO;
}

- (void)dealloc
{
    NSLog(@"SignUp");
}

@end
