//
//  FCBaseTableViewCell.h
//  FitCook
//
//  Created by Joyoki on 2018/7/29.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCBaseTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath;

@end
