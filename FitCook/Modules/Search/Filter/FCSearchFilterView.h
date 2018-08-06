//
//  FCSearchFilterView.h
//  FitCook
//
//  Created by Jay on 2018/8/6.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FCSearchFilterViewDelegate;

@interface FCSearchFilterView : UIView

@property (nonatomic, weak) id <FCSearchFilterViewDelegate> delegate;

@property (nonatomic, readonly) NSString *title;

@property (nonatomic, strong) NSMutableArray<UIButton *> *arrFilter;

@property (nonatomic, strong) NSSet<NSNumber *> *selectedIndexs;

@end


@protocol FCSearchFilterViewDelegate <NSObject>

- (void)searchFilterView:(FCSearchFilterView *)view onClickItemWithIndex:(NSInteger)index;

@end
