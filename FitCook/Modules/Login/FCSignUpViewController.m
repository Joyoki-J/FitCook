//
//  FCSignUpViewController.m
//  FitCook
//
//  Created by shanshan on 2018/8/6.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCSignUpViewController.h"

@interface FCSignUpViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) NSArray<UITextField *> *arrtf;

@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfName;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;

@property (nonatomic, strong) UITextField *tfFirstResponder;

@property (nonatomic, assign) CGRect keyboardRect;
@property (nonatomic, assign) UIViewAnimationCurve animationCurve;
@property (nonatomic, assign) CGFloat animateSpeed;

@end

@implementation FCSignUpViewController

+ (NSString *)storyboardName {
    return @"Login";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _arrtf = @[_tfEmail, _tfName, _tfPassword];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (IBAction)onClickSignUpAction:(UIButton *)sender {
    
    NSString *email    = _tfEmail.text;
    NSString *name     = _tfName.text;
    NSString *password = _tfPassword.text;
    
    NSString *msg = [FCUser addUserWithEmail:email password:password name:name];
    
    if (msg) {
        [FCToast showErrorText:msg];
        return;
    }
    
    if ([_delegate respondsToSelector:@selector(signUpViewController:signUpWithEmail:password:)]) {
        [_delegate signUpViewController:self signUpWithEmail:email password:password];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)onClickSignInAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self getLineViewWithTextField:textField].backgroundColor = RGB(32, 205, 173);
    _tfFirstResponder = textField;
    CGRect rect = [self.view convertRect:_tfFirstResponder.frame fromView:_tfFirstResponder.superview];
    if (!CGRectIsEmpty(_keyboardRect) && rect.origin.y + rect.size.height > _keyboardRect.origin.y) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:_animateSpeed];
        [UIView setAnimationCurve:_animationCurve];
        self.view.minY = _keyboardRect.origin.y - (rect.origin.y + rect.size.height);
        [UIView commitAnimations];
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [self getLineViewWithTextField:textField].backgroundColor = RGB(209, 209, 214);
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSInteger index = [_arrtf indexOfObject:textField];
    if (index == _arrtf.count - 1) {
        [textField resignFirstResponder];
    } else {
        [[_arrtf objectAtIndex:index + 1] becomeFirstResponder];
    }
    return YES;
}

- (UIView *)getLineViewWithTextField:(UITextField *)tf {
    return tf ? [[tf superview] viewWithTag:88] : nil;
}

- (void)keyboardWillShow:(NSNotification *)noti {
    NSDictionary *userInfo = [noti userInfo];
    CGFloat animateSpeed = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    UIViewAnimationCurve animateCurve = [[noti.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    CGRect keyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect rect = [self.view convertRect:_tfFirstResponder.frame fromView:_tfFirstResponder.superview];
    if (rect.origin.y + rect.size.height > keyboardRect.origin.y) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:animateSpeed];
        [UIView setAnimationCurve:animateCurve];
        self.view.minY = keyboardRect.origin.y - (rect.origin.y + rect.size.height);
        [UIView commitAnimations];
    }
    _animateSpeed = animateSpeed;
    _animationCurve = animateCurve;
    _keyboardRect = keyboardRect;
}

- (void)keyboardWillHide:(NSNotification *)noti {
    if (self.view.minY != 0) {
        NSDictionary *userInfo = [noti userInfo];
        CGFloat animateSpeed = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
        UIViewAnimationCurve animateCurve = [[noti.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:animateSpeed];
        [UIView setAnimationCurve:animateCurve];
        self.view.minY = 0;
        [UIView commitAnimations];
    }
    _keyboardRect = CGRectZero;
}

- (IBAction)onClickCloseAction:(UIButton *)sender {
    [[FCRootViewController shareViewController] hideLoginViewController];
}


#pragma mark - Override

- (BOOL)needsHiddenNavigationBar {
    return YES;
}

- (BOOL)canDragBackFromNavigationController {
    return NO;
}

@end
