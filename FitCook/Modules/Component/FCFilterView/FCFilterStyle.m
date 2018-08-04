//
//  FCFilterStyle.m
//  FitCook
//
//  Created by Joyoki on 2018/8/5.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCFilterStyle.h"

@implementation FCFilterStyle

- (instancetype)init
{
    self = [super init];
    if (self) {
        _textColor = kCOLOR_GRAY_TITLE;
        _borderColor = kCOLOR_GRAY_BORDER;
        _borderColorSelected = kCOLOR_BLUE_BORDER;
        _itemColor = [UIColor whiteColor];
    }
    return self;
}


@end
