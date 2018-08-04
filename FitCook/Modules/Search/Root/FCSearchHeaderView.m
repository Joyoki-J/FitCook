//
//  FCSearchHeaderView.m
//  FitCook
//
//  Created by Joyoki on 2018/8/5.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCSearchHeaderView.h"
#import "FCFilterView.h"

@interface FCSearchHeaderView()

@property (weak, nonatomic) IBOutlet UIView *vFilterBack;
@property (weak, nonatomic) IBOutlet FCFilterView *vFilter;
@property (weak, nonatomic) IBOutlet UIView *vFilterMore;

@property (nonatomic, strong) FCFilterStyle *style1;
@property (nonatomic, strong) FCFilterStyle *style2;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop;

@end

@implementation FCSearchHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
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
        _layTop.constant = 10;
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
        _layTop.constant = 0;
        [UIView animateWithDuration:0.25 animations:^{
            self.vFilterMore.layer.transform = CATransform3DMakeScale(1, 1, 1);
            [self layoutIfNeeded];
        }];
    }
    
//    CGFloat scale = progress * 2.0;
//    if (scale > 1) {
//        scale = 1.0;
//    }
//    _vFilterMore.layer.transform = CATransform3DMakeScale(scale, scale, 1);
    
    _vFilterBack.backgroundColor = RGBA(255, 255, 255, (12 * (1 - progress)));
    
    _progress = progress;
}



@end
