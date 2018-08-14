//
//  FCRecipesRootFilterCell.h
//  FitCook
//
//  Created by shanshan on 2018/8/1.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCBaseTableViewCell.h"

@protocol FCRecipesRootFilterCellDelegate;

@interface FCRecipesRootFilterCell : FCBaseTableViewCell

@property (weak, nonatomic) id <FCRecipesRootFilterCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *imgvFood;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labTime;
@property (nonatomic, assign) BOOL isFavourited;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@protocol FCRecipesRootFilterCellDelegate <NSObject>

- (void)recipesRootFilterCell:(FCRecipesRootFilterCell *)cell didClickFavouriteActionWithIndexPath:(NSIndexPath *)indexPath;

@end
