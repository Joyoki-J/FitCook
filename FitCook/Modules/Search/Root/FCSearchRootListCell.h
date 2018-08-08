//
//  FCSearchRootListCell.h
//  FitCook
//
//  Created by Jay on 2018/8/3.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCBaseTableViewCell.h"

@interface FCSearchRootListCell : FCBaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgvFood;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labTime;

@property (nonatomic, assign) BOOL isFavourited;

@end
