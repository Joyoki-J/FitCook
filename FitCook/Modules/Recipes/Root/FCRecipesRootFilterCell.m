//
//  FCRecipesRootFilterCell.m
//  FitCook
//
//  Created by Jay on 2018/8/1.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCRecipesRootFilterCell.h"

@interface FCRecipesRootFilterCell()

@property (weak, nonatomic) IBOutlet UIButton *btnFavourite;

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

- (IBAction)onClickFavouriteAction:(UIButton *)sender {
    self.isFavourited = !_isFavourited;
}

- (void)setIsFavourited:(BOOL)isFavourited {
    _isFavourited = isFavourited;
    UIImage *image = isFavourited ? [UIImage imageNamed:@"icon_favourite_like"] : [UIImage imageNamed:@"icon_favourite_unlike"];
    [_btnFavourite setImage:image forState:UIControlStateNormal];
}

@end
