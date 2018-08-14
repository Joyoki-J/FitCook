//
//  FCFilterView.m
//  FitCook
//
//  Created by shanshan on 2018/7/29.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCFilterView.h"
#import "FCFilterCell.h"




@interface FCFilterView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray<NSString *> *arrData;

@property (nonatomic, strong) UICollectionView *cvList;

@property (nonatomic, strong) NSMutableArray<NSNumber *> *selectedIndexs;

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
    _style = [[FCFilterStyle alloc] init];
    
    _arrData = @[@"Sugar-free",
                 @"Dairy-free",
                 @"Vegetarian",
                 @"Gluten-free",
                 @"Breakfast",
                 @"Lunch",
                 @"Dinner"];
    _selectedIndexs = [NSMutableArray arrayWithArray:@[@(NO),@(NO),@(NO),@(NO),@(NO),@(NO),@(NO)]];
}

- (void)updateFilters:(NSArray<NSString *> *)filters {
    _selectedIndexs = [NSMutableArray arrayWithArray:@[@(NO),@(NO),@(NO),@(NO),@(NO),@(NO),@(NO)]];
    NSMutableArray<NSString *> *titles = [NSMutableArray array];
    [_arrData enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([filters containsObject:obj]) {
            self.selectedIndexs[idx] = @(YES);
            [titles addObject:[obj lowercaseString]];
        }
    }];
    _titles = titles;
    [_cvList reloadData];
}

- (void)createSubViews {
    self.backgroundColor = [UIColor clearColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(92, 40);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 8;
    layout.sectionInset = UIEdgeInsetsMake(0, 14, 0, 14);
    _cvList = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _cvList.backgroundColor = [UIColor clearColor];
    _cvList.delegate = self;
    _cvList.dataSource = self;
    _cvList.showsHorizontalScrollIndicator = NO;
    [_cvList registerClass:[FCFilterCell class] forCellWithReuseIdentifier:@"FCFilterCell"];
    [self addSubview:_cvList];
    [_cvList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)updateStyle:(FCFilterStyle *)style {
    _style = style;
    
    __weak typeof(self) weakSelf = self;
    NSArray<FCFilterCell *> *arrFilterCell = [_cvList visibleCells];
    [arrFilterCell enumerateObjectsUsingBlock:^(FCFilterCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setupWithStyle:weakSelf.style];
    }];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _arrData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FCFilterCell *cell = [FCFilterCell cellWithCollectionView:collectionView andIndexPath:indexPath];
    cell.labTitle.text = _arrData[indexPath.row];
    cell.isSelected = [[_selectedIndexs objectAtIndex:indexPath.row] boolValue];
    [cell setupWithStyle:_style];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([_delegate respondsToSelector:@selector(filterView:willSelectedIndex:withTitle:)]) {
        if (![_delegate filterView:self willSelectedIndex:indexPath.row withTitle:_arrData[indexPath.row]]) {
            return;
        }
    }
    
    if ([[_selectedIndexs objectAtIndex:indexPath.row] boolValue]) {
        _selectedIndexs[indexPath.row] = @(NO);
        [collectionView reloadData];
    } else {
        if (indexPath.row >= 4) {
            _selectedIndexs[4] = @(NO);
            _selectedIndexs[5] = @(NO);
            _selectedIndexs[6] = @(NO);
        }
        _selectedIndexs[indexPath.row] = @(YES);
        [collectionView reloadData];
        [self scrollCollectionViewIfNeed:collectionView withIndexPath:indexPath];
    }
    NSMutableArray<NSNumber *> *indexs = [NSMutableArray array];
    NSMutableArray<NSString *> *titles = [NSMutableArray array];
    for (NSInteger i = 0; i < _selectedIndexs.count; i++) {
        if ([_selectedIndexs[i] boolValue]) {
            [indexs addObject:@(i)];
            [titles addObject:[_arrData[i] lowercaseString]];
        }
    }
    _titles = titles;
    if ([_delegate respondsToSelector:@selector(filterView:didSelectedIndexs:withTitles:)]) {
        [_delegate filterView:self didSelectedIndexs:indexs withTitles:titles];
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


