//
//  FCRecipesSegmentedView.h
//  FitCook
//
//  Created by Joyoki on 2018/7/31.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FCRecipesSegmentedViewDelegate;

@interface FCRecipesSegmentedView : UIView

@property (nonatomic, weak) id <FCRecipesSegmentedViewDelegate> delegate;

@property (nonatomic, assign) NSInteger currentIndex;

@end

@protocol FCRecipesSegmentedViewDelegate <NSObject>

- (void)recipesSegmentedView:(FCRecipesSegmentedView *)view didSelectedItemWithIndex:(NSInteger)index;

@end

