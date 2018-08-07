//
//  FCToast.m
//  FitCook
//
//  Created by Jay on 2018/8/7.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCToast.h"

@interface FCToast()

@end

@implementation FCToast

+ (NSMutableArray<FCToast *> *)toastArray {
    static NSMutableArray<FCToast *> *arrToast;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        arrToast = [NSMutableArray array];
    });
    return arrToast;
}

- (instancetype)initWithText:(NSString *)text isError:(BOOL)isError
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView *imgvBack = [[UIImageView alloc] init];
        imgvBack.frame = CGRectMake(0, 0, kSCREEN_WIDTH, 0);
        imgvBack.image = [UIImage imageNamed:@"icon_toast_back"];
        [self addSubview:imgvBack];
        
        UIImageView *imgvError = [[UIImageView alloc] init];
        imgvError.frame = CGRectMake(0, 0, 17, 17);
        imgvError.image = [UIImage imageNamed:@"icon_toast_error"];
        [self addSubview:imgvError];
        
        UILabel *labText = [[UILabel alloc] init];
        labText.text = text;
        labText.font = kFont_15;
        labText.numberOfLines = 0;
        [self addSubview:labText];
        
        [imgvBack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.bottom.mas_equalTo(0);
        }];
        
        [imgvError mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(isError ? 17 : 0);
            make.top.equalTo(labText.mas_top).offset(2);
            make.leading.mas_equalTo(30);
            make.trailing.equalTo(labText.mas_leading).offset(isError ? -5 : 0);
        }];
        
        [labText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.bottom.mas_equalTo(-20);
            make.trailing.mas_equalTo(-30);
        }];
    }
    return self;
}

- (void)show {
    self.alpha = 0;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kSTATBAR_HEIGHT);
        make.leading.trailing.mas_equalTo(0);
    }];
    
    self.transform = CGAffineTransformMakeScale(0.7, 0.7);
    [[[self class] toastArray] addObject:self];
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeToasts];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hide];
        });
    }];
}

- (void)removeToasts {
    while ([[self class] toastArray].count > 1) {
        [[[self class] toastArray].firstObject removeFromSuperview];
        [[[self class] toastArray] removeObjectAtIndex:0];
    }
}

- (void)hide {
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

+ (void)showText:(NSString *)text {
    [[self class] showText:text isError:NO];
}

+ (void)showErrorText:(NSString *)text {
    [[self class] showText:text isError:YES];
}

+ (void)showText:(NSString *)text isError:(BOOL)isError {
    FCToast *toast = [[FCToast alloc] initWithText:text isError:isError];
    [toast show];
}

@end
