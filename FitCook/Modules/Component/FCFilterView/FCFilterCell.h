//
//  FCFilterCell.h
//  FitCook
//
//  Created by Joyoki on 2018/7/29.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCBaseCollectionViewCell.h"

@class FCFilterStyle;

@interface FCFilterCell : FCBaseCollectionViewCell

@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, assign) BOOL isSelected;

- (void)setupWithStyle:(FCFilterStyle *)style;

@end
