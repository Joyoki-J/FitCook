//
//  FCModalTransition.m
//  FitCook
//
//  Created by Joyoki on 2018/8/3.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCModalTransition.h"

@interface FCModalTransition()

@property (nonatomic, assign) BOOL isPresnted;

@property (nonatomic, weak) UIViewController *presentViewController;

@end

@implementation FCModalTransition

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.isPresnted = YES;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.isPresnted = NO;
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration {
    return self.isPresnted ? 0.8 : 0.25;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return [self transitionDuration];
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.isPresnted) {
        [self present:transitionContext];
    } else {
        [self dismiss:transitionContext];
    }
}

- (void)present:(id<UIViewControllerContextTransitioning>)transitonContext {
    UIView *containerView = [transitonContext containerView];
    UIViewController *toVC = [transitonContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *vMask = [[UIView alloc] initWithFrame:containerView.bounds];
    vMask.backgroundColor = RGBA(0, 0, 0, 10);
    vMask.alpha = 0;
    vMask.tag = 666;
    [containerView addSubview:vMask];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [vMask addGestureRecognizer:tap];
    
    
    toVC.view.frame = CGRectMake(-kSCREEN_WIDTH, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
    [containerView addSubview:toVC.view];
    
    [UIView animateWithDuration:[self transitionDuration] delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        vMask.alpha = 1;
        toVC.view.frame = CGRectMake(280 - kSCREEN_WIDTH, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        [transitonContext completeTransition:YES];
        self.presentViewController = toVC;
    }];
}

- (void)dismiss:(id<UIViewControllerContextTransitioning>)transitonContext {
    UIView *containerView = [transitonContext containerView];
    UIViewController *fromVC = [transitonContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *vMask = [containerView viewWithTag:666];
    
    [UIView animateWithDuration:[self transitionDuration] animations:^{
        vMask.alpha = 0;
        fromVC.view.frame = CGRectMake(-kSCREEN_WIDTH, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        [transitonContext completeTransition:YES];
    }];
    
}

- (void)dismiss {
    if (self.isPresnted && self.presentViewController) {
        [self.presentViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)dealloc
{
    NSLog(@"FCModalTransition !!!");
}

@end
