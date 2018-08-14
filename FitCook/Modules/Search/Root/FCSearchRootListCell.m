//
//  FCSearchRootListCell.m
//  FitCook
//
//  Created by shanshan on 2018/8/3.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCSearchRootListCell.h"
#import "FCParticleButton.h"

@interface FCSearchRootListCell()

@property (weak, nonatomic) IBOutlet FCParticleButton *btnFavourite;

@end

@implementation FCSearchRootListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
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
    if ([_delegate respondsToSelector:@selector(searchRootListCell:didClickFavouriteActionWithIndexPath:)]) {
        [_delegate searchRootListCell:self didClickFavouriteActionWithIndexPath:_indexPath];
    }
}

- (void)setIsFavourited:(BOOL)isFavourited {
    _isFavourited = isFavourited;
    [_btnFavourite setSelected:isFavourited];
}

@end
