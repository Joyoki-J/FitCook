//
//  FCOnePixelLine.m
//  FitCook
//
//  Created by shanshan on 2018/8/1.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCOnePixelLine.h"

@implementation FCOnePixelLine

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _isHorizontal = YES;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _isHorizontal = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSLayoutAttribute layoutAttribute = _isHorizontal == YES ? NSLayoutAttributeHeight : NSLayoutAttributeWidth;
    for (NSLayoutConstraint *constraint in self.constraints) {
        if ((UIView *)constraint.firstItem == self && constraint.firstAttribute == layoutAttribute) {
            [self removeConstraint:constraint];
            constraint.constant = 1.0 / [UIScreen mainScreen].scale;
            [self addConstraint:constraint];
        }
    }
}
@end
