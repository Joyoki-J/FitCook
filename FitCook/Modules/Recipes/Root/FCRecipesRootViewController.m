//
//  FCRecipesRootViewController.m
//  FitCook
//
//  Created by Joyoki on 2018/7/26.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCRecipesRootViewController.h"
#import "FCRecipesRootListCell.h"
#import "FCRecipesRootFilterCell.h"
#import "FCFilterView.h"
#import "FCRecipesDetailViewController.h"

@interface FCRecipesRootViewController()<UITableViewDataSource, UITableViewDelegate, FCFilterViewDelegate, FCRecipesRootListCellDelegate>

@property (weak, nonatomic) IBOutlet FCFilterView *vFilter;

@property (weak, nonatomic) IBOutlet UITableView *tvList;

@property (nonatomic, copy) NSString *currentSeletecdFilter;

@end

@implementation FCRecipesRootViewController

+ (NSString *)storyboardName {
    return @"Recipes";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _vFilter.delegate = self;
    _tvList.estimatedRowHeight = 0;
    _tvList.estimatedSectionFooterHeight = 0;
    _tvList.estimatedSectionHeaderHeight = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return _currentSeletecdFilter ? 2 : 8;
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 14;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _currentSeletecdFilter ? 148 : 218;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_currentSeletecdFilter) {
        FCRecipesRootFilterCell *cell = [FCRecipesRootFilterCell cellWithTableView:tableView andIndexPath:indexPath];
        return cell;
    } else {
        FCRecipesRootListCell *cell = [FCRecipesRootListCell cellWithTableView:tableView andIndexPath:indexPath];
        cell.delegate = self;
        cell.section = indexPath.row;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_currentSeletecdFilter) {
        NSLog(@"点击 - 有筛选 - %ld",indexPath.row);
        FCRecipesDetailViewController *vcRecipesDetail = [FCRecipesDetailViewController viewControllerFromStoryboard];
        [self.navigationController pushViewController:vcRecipesDetail animated:YES];
    }
}

#pragma mark - FCRecipesRootListCellDelegate
- (void)recipesRootListCell:(FCRecipesRootListCell *)cell didSelectedItemWithIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击 - 无筛选 - section=%ld row=%ld",indexPath.section,indexPath.row);
    FCRecipesDetailViewController *vcRecipesDetail = [FCRecipesDetailViewController viewControllerFromStoryboard];
    [self.navigationController pushViewController:vcRecipesDetail animated:YES];
}

#pragma mark - FCFilterViewDelegate
- (void)filterView:(FCFilterView *)view didSelectedIndex:(NSInteger)index withTitle:(NSString *)title {
    _currentSeletecdFilter = title;
    [_tvList reloadData];
}

@end
