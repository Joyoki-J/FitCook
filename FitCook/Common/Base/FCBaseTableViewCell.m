//
//  FCBaseTableViewCell.m
//  FitCook
//
//  Created by Joyoki on 2018/7/29.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCBaseTableViewCell.h"

@implementation FCBaseTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = NSStringFromClass([self class]);
    return [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
