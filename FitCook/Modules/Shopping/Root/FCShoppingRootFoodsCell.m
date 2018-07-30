//
//  FCShoppingRootFoodsCell.m
//  FitCook
//
//  Created by Joyoki on 2018/7/30.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCShoppingRootFoodsCell.h"

@interface FCShoppingRootFoodsCell()


@property (weak, nonatomic) IBOutlet UIImageView *imgvSeleced;

@end

@implementation FCShoppingRootFoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    _imgvSeleced.image = isSelected ? [UIImage imageNamed:@"icon_shopping_selected"] : [UIImage imageNamed:@"icon_shopping_unselected"];
}

@end
