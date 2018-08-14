//
//  FCUIManager.m
//  FitCook
//
//  Created by shanshan on 2018/7/16.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCUIManager.h"

#define Resolution_1242X2208_3X CGSizeMake(1242.0f, 2208.0f)

@implementation FCUIManager

+ (FCScreenSize)currentScreenSize {
    static enum FCScreenSize _currentSize = FCS_None;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGSize screenSize =  [[UIScreen mainScreen] bounds].size;
        if (CGSizeEqualToSize(screenSize, CGSizeMake(320, 480))) {
            _currentSize = FCS_ScreenSize_3_5;
        } else if (CGSizeEqualToSize(screenSize, CGSizeMake(320, 568))) {
            _currentSize = FCS_ScreenSize_4_0;
        } else if (CGSizeEqualToSize(screenSize, CGSizeMake(375, 667))) {
            _currentSize = FCS_ScreenSize_4_7;
        } else if (CGSizeEqualToSize(screenSize, CGSizeMake(414, 736))) {
            _currentSize = FCS_ScreenSize_5_5;
        } else if (CGSizeEqualToSize(screenSize, CGSizeMake(375, 812))) {
            _currentSize = FCS_ScreenSize_5_8;
        } else {
            _currentSize = FCS_ScreenSize_4_7;
        }
    });
    return _currentSize;
}

+ (UIFont *)fontOfSize:(CGFloat)size bold:(BOOL)bold {
    if (bold) {
        return [UIFont boldSystemFontOfSize:size];
    } else {
        return [UIFont systemFontOfSize:size];
    }
}

@end
