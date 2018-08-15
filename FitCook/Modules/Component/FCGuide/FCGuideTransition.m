//
//  FCGuideTransition.m
//  FitCook
//
//  Created by shanshan on 2018/8/15.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCGuideTransition.h"
#import "FCGuideViewController.h"

@interface FCGuideTransition()

@property (nonatomic, assign) BOOL isPresnted;

@end

@implementation FCGuideTransition

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
    return 0.01;
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
    FCGuideViewController *toVC = [transitonContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    toVC.view.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
    [containerView addSubview:toVC.view];
    
    [toVC showGuide:^{
        [transitonContext completeTransition:YES];
    }];
    
}

- (void)dismiss:(id<UIViewControllerContextTransitioning>)transitonContext {
    FCGuideViewController *fromVC = [transitonContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [fromVC hideGuide:^{    
        [transitonContext completeTransition:YES];
    }];
    
}
@end
