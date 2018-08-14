//
//  FCRecipesRootItemCell.h
//  FitCook
//
//  Created by shanshan on 2018/7/29.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCBaseCollectionViewCell.h"

@protocol FCRecipesRootItemCellDelegate;

@interface FCRecipesRootItemCell : FCBaseCollectionViewCell

@property (weak, nonatomic) id<FCRecipesRootItemCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *imgvFood;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labTime;
@property (nonatomic, assign) BOOL isFavourited;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@protocol FCRecipesRootItemCellDelegate <NSObject>

- (void)recipesRootItemCell:(FCRecipesRootItemCell *)cell didClickFavouriteActionWithIndexPath:(NSIndexPath *)indexPath;

@end
