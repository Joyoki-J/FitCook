
//
//  FCFractionalView.m
//  FitCook
//
//  Created by shanshan on 2018/8/13.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCFractionalView.h"
#import "FCRecipe.h"

@interface FCFractionalView()

@property (nonatomic, strong) UILabel *labSeparator;
@property (nonatomic, strong) UILabel *labNumerator;
@property (nonatomic, strong) UILabel *labDenominator;

@end

@implementation FCFractionalView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _labNumerator = [self createLabel];
        _labNumerator.font = kFont(9);
        [self addSubview:_labNumerator];
        
        _labSeparator = [self createLabel];
        _labSeparator.font = kFont(16);
        [self addSubview:_labSeparator];
        
        _labDenominator = [self createLabel];
        _labDenominator.font = kFont(9);
        [self addSubview:_labDenominator];
        
        [_labNumerator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.equalTo(self.labSeparator.mas_left).offset(2);
            make.top.equalTo(self.labSeparator.mas_top).offset(2);
        }];
        
        [_labSeparator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
        }];
        
        [_labDenominator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.labSeparator.mas_right).offset(-2);
            make.bottom.equalTo(self.labSeparator.mas_bottom).offset(-1);
            make.right.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)setValueWithNumerator:(NSInteger)numerator
               andDenominator:(NSInteger)denominator {
    if (numerator == 0 || denominator == 0) {
        _labNumerator.text = nil;
        _labDenominator.text = nil;
        _labSeparator.text = nil;
    } else {
        _labNumerator.text = [NSString stringWithFormat:@"%ld",numerator];
        _labDenominator.text = [NSString stringWithFormat:@"%ld",denominator];
        _labSeparator.text = @"/";
    }
}

- (UILabel *)createLabel {
    UILabel *lab = [[UILabel alloc] init];
    lab.textColor = RGB(99, 99, 102);
    lab.textAlignment = NSTextAlignmentCenter;
    return lab;
}

@end
