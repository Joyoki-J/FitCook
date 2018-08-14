//
//  FCSearchRootListCell.h
//  FitCook
//
//  Created by shanshan on 2018/8/3.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCBaseTableViewCell.h"

@protocol FCSearchRootListCellDelegate;

@interface FCSearchRootListCell : FCBaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgvFood;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labTime;

@property (nonatomic, weak) id <FCSearchRootListCellDelegate> delegate;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, assign) BOOL isFavourited;

@end

@protocol FCSearchRootListCellDelegate <NSObject>

- (void)searchRootListCell:(FCSearchRootListCell *)cell didClickFavouriteActionWithIndexPath:(NSIndexPath *)indexPath;

@end
