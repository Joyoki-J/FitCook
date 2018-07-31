//
//  FCRecipesSegmentedView.m
//  FitCook
//
//  Created by Joyoki on 2018/7/31.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCRecipesSegmentedView.h"

@interface FCRecipesSegmentedView()

@end

@implementation FCRecipesSegmentedView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _currentIndex = 0;
}

- (IBAction)onClickItemAction:(UITapGestureRecognizer *)sender {
    UILabel *itemSelected = (UILabel *)sender.view;
    NSInteger indexSelected = itemSelected.tag - 10;
    if (indexSelected != _currentIndex) {
        UILabel *itemLast = [self viewWithTag:_currentIndex + 10];
        itemLast.backgroundColor = [UIColor whiteColor];
        itemLast.textColor = kCOLOR_GRAY_142_142_142;
        itemSelected.backgroundColor = [UIColor clearColor];
        itemSelected.textColor = [UIColor whiteColor];
        _currentIndex = indexSelected;
        if ([_delegate respondsToSelector:@selector(recipesSegmentedView:didSelectedItemWithIndex:)]) {
            [_delegate recipesSegmentedView:self didSelectedItemWithIndex:_currentIndex];
        }
    }
}


@end
