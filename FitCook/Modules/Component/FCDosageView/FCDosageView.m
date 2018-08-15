//
//  FCDosageView.m
//  FitCook
//
//  Created by shanshan on 2018/8/13.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCDosageView.h"
#import "FCRecipe.h"
#import "FCFractionalView.h"

@interface FCDosageView()

@property (nonatomic, strong) UILabel *labInteger;
@property (nonatomic, strong) FCFractionalView *labFractional;
@property (nonatomic, strong) UILabel *labUnit;

@end

@implementation FCDosageView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _labInteger = [self createLabel];
    [self addSubview:_labInteger];
    
    _labFractional = [[FCFractionalView alloc] init];
    [self addSubview:_labFractional];
    
    _labUnit = [self createLabel];
    [self addSubview:_labUnit];
    
    [_labInteger mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_equalTo(0);
    }];
    
    [_labFractional mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labInteger.mas_right);
        make.centerY.equalTo(self.labInteger.mas_centerY);
        make.height.equalTo(self.labInteger.mas_height);
    }];
    
    [_labUnit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labFractional.mas_right);
        make.right.mas_equalTo(0);
        make.centerY.equalTo(self.labInteger.mas_centerY);
        make.height.equalTo(self.labInteger.mas_height);
    }];
}

- (void)setTextWithDosage:(FCRecipeDosage *)dosage {
    if ([dosage isKindOfClass:[FCRecipeDosage class]]) {
        _labInteger.text = dosage.integer > 0 ? [NSString stringWithFormat:@"%ld",(long)dosage.integer] : nil;
        [_labFractional setValueWithNumerator:dosage.numerator andDenominator:dosage.denominator];
        _labUnit.text = dosage.unit && dosage.unit.length > 0 ? [NSString stringWithFormat:@" %@",dosage.unit] : nil;
    } else {
        _labInteger.text = nil;
        [_labFractional setValueWithNumerator:0 andDenominator:0];
        _labUnit.text = nil;
    }
}

- (UILabel *)createLabel {
    UILabel *lab = [[UILabel alloc] init];
    lab.textColor = RGB(99, 99, 102);
    lab.font = kFont_16;
    lab.textAlignment = NSTextAlignmentCenter;
    return lab;
}

@end
