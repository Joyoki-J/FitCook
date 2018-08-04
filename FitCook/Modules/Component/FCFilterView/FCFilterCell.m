//
//  FCFilterCell.m
//  FitCook
//
//  Created by Joyoki on 2018/7/29.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCFilterCell.h"
#import "FCFilterStyle.h"

@implementation FCFilterCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _labTitle = [[UILabel alloc] init];
        _labTitle.textAlignment = NSTextAlignmentCenter;
        _labTitle.font = kFont_14;
        _labTitle.layer.borderWidth = 2.f;
        _labTitle.layer.cornerRadius = 2.f;
        _labTitle.clipsToBounds = YES;
        [self.contentView addSubview:_labTitle];
        [_labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    return self;
}

- (void)setupWithStyle:(FCFilterStyle *)style {
    _labTitle.textColor = style.textColor;
    _labTitle.layer.borderColor = _isSelected ? [style.borderColorSelected CGColor] : [style.borderColor CGColor];
    _labTitle.backgroundColor = style.itemColor;
}

@end
