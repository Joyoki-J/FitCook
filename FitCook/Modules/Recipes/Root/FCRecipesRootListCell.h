//
//  FCRecipesRootListCell.h
//  FitCook
//
//  Created by Joyoki on 2018/7/29.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCBaseTableViewCell.h"

@protocol FCRecipesRootListCellDelegate;

@interface FCRecipesRootListCell : FCBaseTableViewCell

@property (nonatomic, weak) id <FCRecipesRootListCellDelegate> delegate;
@property (nonatomic, assign) NSInteger section;
- (void)makeCellWithData:(NSMutableArray<FCRecipe *> *)data;

@end


@protocol FCRecipesRootListCellDelegate<NSObject>

- (void)recipesRootListCell:(FCRecipesRootListCell *)cell didSelectedItemWithIndexPath:(NSIndexPath *)indexPath;

@end
