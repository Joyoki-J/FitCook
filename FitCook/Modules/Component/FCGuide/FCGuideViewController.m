//
//  FCGuideViewController.m
//  FitCook
//
//  Created by shanshan on 2018/8/15.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCGuideViewController.h"
#import "FCGuideTransition.h"

@interface FCGuideViewController ()

@property (nonatomic, strong) FCGuideTransition *transition;

@property (nonatomic, strong) UIView *vMask;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, assign) BOOL isAnimating;

@end

@implementation FCGuideViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _transition = [[FCGuideTransition alloc] init];
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = _transition;
        
        _currentIndex = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    _vMask = [[UIView alloc] initWithFrame:self.view.bounds];
    _vMask.backgroundColor = RGBA(0, 0, 0, 19);
    _vMask.alpha = 0;
    [self.view addSubview:_vMask];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickAction:)];
    [_vMask addGestureRecognizer:tap];
}

- (void)onClickAction:(UITapGestureRecognizer *)tap {
    if (_isAnimating) {
        return;
    }
    self.isAnimating = YES;
    if (self.currentIndex == self.guides.count - 1) {
        [[self.guides objectAtIndex:self.currentIndex] hide:^{
            
        }];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        __weak typeof(self) weakSelf = self;
        [[self.guides objectAtIndex:self.currentIndex] hide:^{
            [[weakSelf.guides objectAtIndex:weakSelf.currentIndex + 1] showWithTarget:weakSelf.view completion:^(NSInteger index) {
                weakSelf.currentIndex = index;
                weakSelf.isAnimating = NO;
            }];
        }];
    }
}

- (void)showGuide:(void(^)(void))completion {
    _isAnimating = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.vMask.alpha = 1;
    } completion:^(BOOL finished) {
        completion();
    }];
    [_guides[0] showWithTarget:self.view completion:^(NSInteger index) {
        self.currentIndex = index;
        self.isAnimating = NO;
    }];
}

- (void)hideGuide:(void(^)(void))completion {
    [UIView animateWithDuration:0.2 animations:^{
        self.vMask.alpha = 0;
    } completion:^(BOOL finished) {
        completion();
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark - Override

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
