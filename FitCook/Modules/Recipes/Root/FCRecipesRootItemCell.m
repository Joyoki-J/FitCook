//
//  FCRecipesRootItemCell.m
//  FitCook
//
//  Created by Joyoki on 2018/7/29.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCRecipesRootItemCell.h"
#import "FCParticleButton.h"

@interface FCRecipesRootItemCell()

@property (weak, nonatomic) IBOutlet FCParticleButton *btnFavourite;

@end

@implementation FCRecipesRootItemCell


- (IBAction)onClickFavouriteAction:(FCParticleButton *)sender {
    if (sender.selected) {
        [sender popInsideWithDuration:0.4f];
    } else {
        [sender popOutsideWithDuration:0.5f];
        [sender animate];
    }
    if ([_delegate respondsToSelector:@selector(recipesRootItemCell:didClickFavouriteActionWithIndexPath:)]) {
        [_delegate recipesRootItemCell:self didClickFavouriteActionWithIndexPath:_indexPath];
    }
}

- (void)setIsFavourited:(BOOL)isFavourited {
    _isFavourited = isFavourited;
    [_btnFavourite setSelected:isFavourited];
}

@end
