//
//  FCFilterView.h
//  FitCook
//
//  Created by Joyoki on 2018/7/29.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FCFilterStyle.h"

@protocol FCFilterViewDelegate;

@interface FCFilterView : UIView

@property (nonatomic, weak) id <FCFilterViewDelegate> delegate;

@property (nonatomic, strong) FCFilterStyle *style;

- (void)updateStyle:(FCFilterStyle *)style;

@end

@protocol FCFilterViewDelegate <NSObject>

- (void)filterView:(FCFilterView *)view didSelectedIndexs:(NSArray<NSNumber *> *)indexs withTitles:(NSArray<NSString *> *)titles;

@end

