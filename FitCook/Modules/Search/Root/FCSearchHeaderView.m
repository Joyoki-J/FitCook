//
//  FCSearchHeaderView.m
//  FitCook
//
//  Created by Joyoki on 2018/8/5.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCSearchHeaderView.h"
#import "FCFilterView.h"

@interface FCSearchHeaderView()<FCFilterViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *vFilterBack;
@property (weak, nonatomic) IBOutlet FCFilterView *vFilter;
@property (weak, nonatomic) IBOutlet UIView *vFilterMore;

@property (nonatomic, strong) FCFilterStyle *style1;
@property (nonatomic, strong) FCFilterStyle *style2;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutBottom;

@end

@implementation FCSearchHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _vFilter.delegate = self;
    
    _style1 = [[FCFilterStyle alloc] init];

    FCFilterStyle *style2 = [[FCFilterStyle alloc] init];
    style2.itemColor = RGBA(5, 5, 5, 5);
    style2.textColor = [UIColor whiteColor];
    style2.borderColor = [UIColor clearColor];
    style2.borderColorSelected = [UIColor whiteColor];
    _style2 = style2;
}

- (void)setProgress:(CGFloat)progress {
    
    if (_progress > 0.5 && progress <= 0.5) {
        [_vFilter updateStyle:_style2];
        _layoutBottom.constant = 0;
        [UIView animateWithDuration:0.25 animations:^{
            self.vFilterMore.layer.transform = CATransform3DMakeScale(0.01, 0.01, 1);
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.vFilterMore.layer.transform = CATransform3DMakeScale(0, 0, 1);
            self.vFilterMore.hidden = YES;
        }];
    } else if (_progress <= 0.5 && progress > 0.5) {
        [_vFilter updateStyle:_style1];
        self.vFilterMore.hidden = NO;
        _layoutBottom.constant = -14;
        [UIView animateWithDuration:0.25 animations:^{
            self.vFilterMore.layer.transform = CATransform3DMakeScale(1, 1, 1);
            [self layoutIfNeeded];
        }];
    }
    
    _vFilterBack.backgroundColor = RGBA(255, 255, 255, (12 * (1 - progress)));
    
    _progress = progress;
}

- (IBAction)onClickScanAction:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(searchHeaderDidClickScanAction:)]) {
        [_delegate searchHeaderDidClickScanAction:self];
    }
}

- (IBAction)onClickSeeAllFilterAction:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(searchHeaderDidClickSeeAllFilterAction:)]) {
        [_delegate searchHeaderDidClickSeeAllFilterAction:self];
    }
}

- (void)filterView:(FCFilterView *)view didSelectedIndex:(NSInteger)index withTitle:(NSString *)title {
    
    _tfSearch.text = title;
    
    if ([_delegate respondsToSelector:@selector(searchHeaderDidSelectedFilter:)]) {
        [_delegate searchHeaderDidSelectedFilter:self];
    }
}

@end
