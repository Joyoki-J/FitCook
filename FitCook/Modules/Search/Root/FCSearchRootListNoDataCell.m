//
//  FCSearchRootListNoDataCell.m
//  FitCook
//
//  Created by shanshan on 2018/8/12.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCSearchRootListNoDataCell.h"

@interface FCSearchRootListNoDataCell()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutTop;


@end

@implementation FCSearchRootListNoDataCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _layoutTop.constant = (kSCREEN_HEIGHT - kSCREEN_WIDTH * 0.75 - 109 - kTABBAR_HEIGHT - 24) / 2.0;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
