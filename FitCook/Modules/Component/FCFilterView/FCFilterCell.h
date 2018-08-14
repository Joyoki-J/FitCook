//
//  FCFilterCell.h
//  FitCook
//
//  Created by shanshan on 2018/7/29.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCBaseCollectionViewCell.h"

@class FCFilterStyle;

@interface FCFilterCell : FCBaseCollectionViewCell

@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, assign) BOOL isSelected;

- (void)setupWithStyle:(FCFilterStyle *)style;

@end
