//
//  FCFilterCell.m
//  FitCook
//
//  Created by Joyoki on 2018/7/29.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCFilterCell.h"

@implementation FCFilterCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _labTitle = [[UILabel alloc] init];
        _labTitle.textColor = kCOLOR_GRAY_TITLE;
        _labTitle.textAlignment = NSTextAlignmentCenter;
        _labTitle.font = kFont_14;
        _labTitle.layer.borderColor = [kCOLOR_GRAY_BORDER CGColor];
        _labTitle.layer.borderWidth = 2.f;
        [self.contentView addSubview:_labTitle];
        [_labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    return self;
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    _labTitle.layer.borderColor = [(isSelected ? kCOLOR_BLUE_BORDER : kCOLOR_GRAY_BORDER) CGColor];
}

@end
