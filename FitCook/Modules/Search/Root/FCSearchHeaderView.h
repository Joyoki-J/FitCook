//
//  FCSearchHeaderView.h
//  FitCook
//
//  Created by Joyoki on 2018/8/5.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FCSearchHeaderViewDelegate;

@interface FCSearchHeaderView : UIView

@property (nonatomic, weak) id<FCSearchHeaderViewDelegate> delegate;

@property(nonatomic, assign) CGFloat progress;
@property (weak, nonatomic) IBOutlet UITextField *tfSearch;

@end

@protocol FCSearchHeaderViewDelegate <NSObject>

- (void)searchHeaderDidClickScanAction:(FCSearchHeaderView *)vHeader;
- (void)searchHeaderDidClickSeeAllFilterAction:(FCSearchHeaderView *)vHeader;
- (void)searchHeaderDidSelectedFilter:(FCSearchHeaderView *)vHeader;

@end
