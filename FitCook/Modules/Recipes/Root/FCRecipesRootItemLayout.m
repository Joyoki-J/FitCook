//
//  FCRecipesRootItemLayout.m
//  FitCook
//
//  Created by Joyoki on 2018/7/29.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCRecipesRootItemLayout.h"

@implementation FCRecipesRootItemLayout

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.itemSize = CGSizeMake(228, 164);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumLineSpacing = 14;
        self.sectionInset = UIEdgeInsetsMake(0, 14, 0, 14);
    }
    return self;
}

@end
