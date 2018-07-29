//
//  FCRecipesRootItemCell.m
//  FitCook
//
//  Created by Joyoki on 2018/7/29.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCRecipesRootItemCell.h"

@interface FCRecipesRootItemCell()

@property (weak, nonatomic) IBOutlet UIButton *btnFavourite;

@end

@implementation FCRecipesRootItemCell


- (IBAction)onClickFavouriteAction:(UIButton *)sender {
    self.isFavourited = !_isFavourited;
}

- (void)setIsFavourited:(BOOL)isFavourited {
    _isFavourited = isFavourited;
    UIImage *image = isFavourited ? [UIImage imageNamed:@"icon_favourite_like"] : [UIImage imageNamed:@"icon_favourite_unlike"];
    [_btnFavourite setImage:image forState:UIControlStateNormal];
}

@end
