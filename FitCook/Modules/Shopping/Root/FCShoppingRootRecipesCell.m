//
//  FCShoppingRootRecipesCell.m
//  FitCook
//
//  Created by shanshan on 2018/7/30.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCShoppingRootRecipesCell.h"

@interface FCShoppingRootRecipesCell()

@property (weak, nonatomic) IBOutlet UIView *vContent;

@end

@implementation FCShoppingRootRecipesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _imgvFood.layer.cornerRadius = 4.f;
    _imgvFood.clipsToBounds = YES;
    
    _vContent.layer.borderColor = [kCOLOR_TAB_BAR_ITEM_TITLE CGColor];
    _vContent.layer.borderWidth = 1.f;
    _vContent.layer.cornerRadius = 4.f;
    _vContent.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
