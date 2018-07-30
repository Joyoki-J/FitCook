//
//  FCShoppingRootFoodsCell.h
//  FitCook
//
//  Created by Joyoki on 2018/7/30.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCBaseTableViewCell.h"

@interface FCShoppingRootFoodsCell : FCBaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labCount;
@property (weak, nonatomic) IBOutlet UILabel *labFoodName;
@property (nonatomic, assign) BOOL isSelected;

@end
