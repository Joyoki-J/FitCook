//
//  FCRecipesRootFilterCell.m
//  FitCook
//
//  Created by Jay on 2018/8/1.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCRecipesRootFilterCell.h"
#import "FCParticleButton.h"

@interface FCRecipesRootFilterCell()

@property (weak, nonatomic) IBOutlet FCParticleButton *btnFavourite;

@end
@implementation FCRecipesRootFilterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onClickFavouriteAction:(FCParticleButton *)sender {
    if (sender.selected) {
        [sender popInsideWithDuration:0.4f];
    } else {
        [sender popOutsideWithDuration:0.5f];
        [sender animate];
    }
    if ([_delegate respondsToSelector:@selector(recipesRootFilterCell:didClickFavouriteActionWithIndexPath:)]) {
        [_delegate recipesRootFilterCell:self didClickFavouriteActionWithIndexPath:_indexPath];
    }
}

- (void)setIsFavourited:(BOOL)isFavourited {
    _isFavourited = isFavourited;
    [_btnFavourite setSelected:isFavourited];
}

@end
