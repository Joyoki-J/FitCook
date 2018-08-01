//
//  FCRecipesRootListCell.m
//  FitCook
//
//  Created by Joyoki on 2018/7/29.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCRecipesRootListCell.h"
#import "FCRecipesRootItemCell.h"

@interface FCRecipesRootListCell()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *cvList;

@end

@implementation FCRecipesRootListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FCRecipesRootItemCell *cell = [FCRecipesRootItemCell cellWithCollectionView:collectionView andIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([_delegate respondsToSelector:@selector(recipesRootListCell:didSelectedItemWithIndexPath:)]) {
        [_delegate recipesRootListCell:self didSelectedItemWithIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:_section]];
    }
}

@end
