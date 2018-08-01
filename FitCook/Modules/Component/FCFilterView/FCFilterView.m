//
//  FCFilterView.m
//  FitCook
//
//  Created by Joyoki on 2018/7/29.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCFilterView.h"
#import "FCFilterCell.h"

@interface FCFilterView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray<NSString *> *arrData;

@property (nonatomic, strong) UICollectionView *cvList;

@property (nonatomic, strong) NSIndexPath *selectIndexPath;

@end

@implementation FCFilterView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupDefaultData];
        [self createSubViews];
    }
    return self;
}

- (void)setupDefaultData {
    _arrData = [NSMutableArray array];
    [_arrData addObjectsFromArray:@[@"Filter",
                                    @"Sugar-free",
                                    @"Vegetarian",
                                    @"Dairy-free",
                                    @"Sugar-free",
                                    @"Breakfast",
                                    @"Lunch",
                                    @"Dinner"]];
}

- (void)createSubViews {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(92, 40);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 8;
    layout.sectionInset = UIEdgeInsetsMake(0, 14, 0, 14);
    _cvList = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _cvList.backgroundColor = [UIColor whiteColor];
    _cvList.delegate = self;
    _cvList.dataSource = self;
    _cvList.showsHorizontalScrollIndicator = NO;
    [_cvList registerClass:[FCFilterCell class] forCellWithReuseIdentifier:@"FCFilterCell"];
    [self addSubview:_cvList];
    [_cvList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _arrData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FCFilterCell *cell = [FCFilterCell cellWithCollectionView:collectionView andIndexPath:indexPath];
    cell.labTitle.text = _arrData[indexPath.row];
    cell.isSelected = _selectIndexPath == indexPath;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *selectedTitle = nil;
    if (_selectIndexPath == indexPath) {
        _selectIndexPath = nil;
        [collectionView reloadData];
    } else {
        _selectIndexPath = indexPath;
        selectedTitle = _arrData[indexPath.row];
        [collectionView reloadData];
        [self scrollCollectionViewIfNeed:collectionView withIndexPath:indexPath];
    }
    if ([_delegate respondsToSelector:@selector(filterView:didSelectedIndex:withTitle:)]) {
        [_delegate filterView:self didSelectedIndex:indexPath.row withTitle:selectedTitle];
    }
}

- (void)scrollCollectionViewIfNeed:(UICollectionView *)collectionView withIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellX = 14.0 + indexPath.row * 100.0;
    CGFloat offsetX = collectionView.contentOffset.x;
    CGFloat leading = cellX - offsetX;
    if (leading < 60) {
        if (indexPath.row == 0) {
            [collectionView setContentOffset:CGPointZero animated:YES];
        } else {
            CGPoint point = CGPointMake(14 + (indexPath.row - 1) * 100 + 46, 0);
            [collectionView setContentOffset:point animated:YES];
        }
    } else if (leading > kSCREEN_WIDTH - 92 - 60) {
        if (indexPath.row == _arrData.count - 1) {
            CGPoint point = CGPointMake(92.0 * _arrData.count + 8.0 * (_arrData.count - 1) + 28.0 - kSCREEN_WIDTH, 0);
            [collectionView setContentOffset:point animated:YES];
        } else {
            CGPoint point = CGPointMake((14.0 + indexPath.row * 100.0) - (kSCREEN_WIDTH - 92 - 60), 0);
            [collectionView setContentOffset:point animated:YES];
        }
    }
}

@end
