//
//  FCGuide.m
//  FitCook
//
//  Created by shanshan on 2018/8/15.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCGuide.h"

@interface FCGuide()

@end

@implementation FCGuide

- (void)showWithTarget:(UIView *)target completion:(void (^)(NSInteger index))completion {
    self.imageView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    self.imageView.alpha = 0;
    [target addSubview:self.imageView];
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.imageView.transform = CGAffineTransformIdentity;
        self.imageView.alpha = 1;
    } completion:^(BOOL finished) {
        completion(self.index);
    }];
}

- (void)hide:(void (^)(void))completion {
    [UIView animateWithDuration:0.2 animations:^{
        self.imageView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        self.imageView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.imageView removeFromSuperview];
        completion();
    }];
}

@end
