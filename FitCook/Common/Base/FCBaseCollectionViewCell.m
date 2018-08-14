//
//  FCBaseCollectionViewCell.m
//  FitCook
//
//  Created by shanshan on 2018/7/29.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCBaseCollectionViewCell.h"

@implementation FCBaseCollectionViewCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = NSStringFromClass([self class]);
    return [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
}

@end
