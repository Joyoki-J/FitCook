//
//  FCRecipesRootListCell.m
//  FitCook
//
//  Created by shanshan on 2018/7/29.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCRecipesRootListCell.h"
#import "FCRecipesRootItemCell.h"

@interface FCRecipesRootListCell()<UICollectionViewDataSource,UICollectionViewDelegate,FCRecipesRootItemCellDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *cvList;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;

@property (nonatomic, strong) NSMutableArray<FCRecipe *> *arrRecipes;

@end

@implementation FCRecipesRootListCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)makeCellWithData:(NSMutableArray<FCRecipe *> *)data {
    _arrRecipes = data;
    [_cvList reloadData];
}

- (void)setSection:(NSInteger)section {
    _section = section;
    NSString *title = @"Today’s Inspiration";
    if (section == 1) {
        title = @"Last Recipes";
    } else if (section == 2) {
        title = @"Low Calories";
    } else if (section == 3) {
        title = @"Quick and Easy";
    } else if (section == 4) {
        title = @"High Protein";
    }
    _labTitle.text = title;
}

#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _arrRecipes.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FCRecipesRootItemCell *cell = [FCRecipesRootItemCell cellWithCollectionView:collectionView andIndexPath:indexPath];
    FCRecipe *recipe = [_arrRecipes objectAtIndex:indexPath.row];
    cell.delegate = self;
    cell.indexPath = indexPath;
    [cell.imgvFood fc_setImageWithName:recipe.imageName_2];
    cell.labTitle.text = recipe.name;
    cell.labTime.text = recipe.time;
    cell.isFavourited = [[FCUser currentUser] isFavouriteRecipe:recipe];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([_delegate respondsToSelector:@selector(recipesRootListCell:didSelectedItemWithIndexPath:)]) {
        [_delegate recipesRootListCell:self didSelectedItemWithIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:_section]];
    }
}

#pragma mark - FCRecipesRootItemCellDelegate
- (void)recipesRootItemCell:(FCRecipesRootItemCell *)cell didClickFavouriteActionWithIndexPath:(NSIndexPath *)indexPath {
    if (![FCApp app].currentUser) {
        [[FCRootViewController shareViewController] showLoginViewController];
        return;
    }
    FCRecipe *recipe = [_arrRecipes objectAtIndex:indexPath.row];
    FCUser *user = [FCUser currentUser];
    [user updateRecipe:recipe isFavourite:!cell.isFavourited];
    cell.isFavourited = !cell.isFavourited;
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserUpdateFavouriteNotificationKey object:NSStringFromClass([self class])];
}

@end
