//
//  FCShoppingRootFoodsCell.m
//  FitCook
//
//  Created by shanshan on 2018/7/30.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCShoppingRootFoodsCell.h"

@interface FCShoppingRootFoodsCell()


@property (weak, nonatomic) IBOutlet UIImageView *imgvSeleced;

@end

@implementation FCShoppingRootFoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _vCount = [[FCDosageView alloc] init];
    [self.contentView addSubview:_vCount];
    [_vCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgvSeleced.mas_right).offset(10);
        make.height.mas_equalTo(20);
        make.centerY.equalTo(self.imgvSeleced.mas_centerY);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    _imgvSeleced.image = isSelected ? [UIImage imageNamed:@"icon_shopping_selected"] : [UIImage imageNamed:@"icon_shopping_unselected"];
}

@end
