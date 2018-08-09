//
//  FCSearchRootListCell.m
//  FitCook
//
//  Created by Jay on 2018/8/3.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCSearchRootListCell.h"

@interface FCSearchRootListCell()

@property (weak, nonatomic) IBOutlet UIButton *btnFavourite;

@end

@implementation FCSearchRootListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onClickFavouriteAction:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(searchRootListCell:didClickFavouriteActionWithIndexPath:)]) {
        [_delegate searchRootListCell:self didClickFavouriteActionWithIndexPath:_indexPath];
    }
}

- (void)setIsFavourited:(BOOL)isFavourited {
    _isFavourited = isFavourited;
    UIImage *image = isFavourited ? [UIImage imageNamed:@"icon_favourite_like"] : [UIImage imageNamed:@"icon_favourite_unlike"];
    [_btnFavourite setImage:image forState:UIControlStateNormal];
}

@end
