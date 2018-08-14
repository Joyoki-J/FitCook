//
//  FCRecipesSegmentedView.h
//  FitCook
//
//  Created by shanshan on 2018/7/31.
//  Copyright © 2018年 shanshan. All rights reserved.
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

