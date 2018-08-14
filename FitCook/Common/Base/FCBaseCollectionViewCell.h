//
//  FCBaseCollectionViewCell.h
//  FitCook
//
//  Created by shanshan on 2018/7/29.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCBaseCollectionViewCell : UICollectionViewCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath;

@end
