//
//  FCSignInViewController.m
//  FitCook
//
//  Created by Joyoki on 2018/8/6.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCSignInViewController.h"
#import "FCSignUpViewController.h"

@interface FCSignInViewController ()

@end

@implementation FCSignInViewController

+ (NSString *)storyboardName {
    return @"Login";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)onClickSignInAction:(UIButton *)sender {

    [[NSNotificationCenter defaultCenter] postNotificationName:FCSignInNotificationKey object:nil];
    
}

- (IBAction)onClickSignUpAction:(UIButton *)sender {
    FCSignUpViewController *vcSignUp = [FCSignUpViewController viewControllerFromStoryboard];
    [self.navigationController pushViewController:vcSignUp animated:YES];
}

#pragma mark - Override

- (BOOL)needsHiddenNavigationBar {
    return YES;
}

- (void)dealloc
{
    NSLog(@"Login");
}

@end
