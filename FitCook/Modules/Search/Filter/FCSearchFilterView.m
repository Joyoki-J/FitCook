//
//  FCSearchFilterView.m
//  FitCook
//
//  Created by Jay on 2018/8/6.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCSearchFilterView.h"

@interface FCSearchFilterView()



@end

@implementation FCSearchFilterView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _selectedIndexs = [NSSet set];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIView *view = [self viewWithTag:99];
    self.arrFilter = [NSMutableArray array];
    [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.layer.cornerRadius = 2.f;
        obj.layer.borderWidth = 2.f;
        [self setButton:obj isSelected:[self.selectedIndexs containsObject:@(idx)]];
        [self.arrFilter addObject:obj];
    }];
}

- (NSString *)title {
    return [(UILabel *)[self viewWithTag:98] text];
}

- (void)setSelectedIndexs:(NSSet<NSNumber *> *)selectedIndexs {
    _selectedIndexs = selectedIndexs;
    [_arrFilter enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self setButton:obj isSelected:[self.selectedIndexs containsObject:@(idx)]];
    }];
}

- (void)setButton:(UIButton *)btn isSelected:(BOOL)isSelected {
    btn.layer.borderColor = isSelected ? [kCOLOR_BLUE_BORDER CGColor] : [kCOLOR_GRAY_BORDER CGColor];
}

- (IBAction)onClickAction:(UIButton *)sender {
    if (![_arrFilter containsObject:sender]) {
        return;
    }
    if ([_delegate respondsToSelector:@selector(searchFilterView:onClickItemWithIndex:)]) {
        NSInteger index = [_arrFilter indexOfObject:sender];
        [_delegate searchFilterView:self onClickItemWithIndex:index];
    }
}


@end
