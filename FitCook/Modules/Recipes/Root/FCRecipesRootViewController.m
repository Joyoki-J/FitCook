//
//  FCRecipesRootViewController.m
//  FitCook
//
//  Created by shanshan on 2018/7/26.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCRecipesRootViewController.h"
#import "FCRecipesRootListCell.h"
#import "FCRecipesRootFilterCell.h"
#import "FCFilterView.h"
#import "FCRecipesDetailViewController.h"

@interface FCRecipesRootViewController()<UITableViewDataSource, UITableViewDelegate, FCFilterViewDelegate, FCRecipesRootListCellDelegate,FCRecipesRootFilterCellDelegate>

@property (weak, nonatomic) IBOutlet FCFilterView *vFilter;

@property (weak, nonatomic) IBOutlet UITableView *tvList;
@property (weak, nonatomic) IBOutlet UIView *vNoData;

@property (nonatomic, strong) NSMutableArray<NSString *> *arrSeletecdFilters;

@property (nonatomic, strong) NSArray <NSMutableArray<FCRecipe *> *> *arrRecipes;
@property (nonatomic, strong) NSMutableArray<FCRecipe *> *arrFilterRecipes;

@property (nonatomic, assign) BOOL isNeedRefresh;

@end

@implementation FCRecipesRootViewController

+ (NSString *)storyboardName {
    return @"Recipes";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userUpdateFavouriteNotification:) name:kUserUpdateFavouriteNotificationKey object:nil];
    
    _arrSeletecdFilters = [NSMutableArray array];
    _arrFilterRecipes = [NSMutableArray array];
    _arrRecipes = @[[NSMutableArray<FCRecipe *> array],
                    [NSMutableArray<FCRecipe *> array],
                    [NSMutableArray<FCRecipe *> array],
                    [NSMutableArray<FCRecipe *> array],
                    [NSMutableArray<FCRecipe *> array]];
    NSArray<FCRecipe *> *recipes = [FCRecipe allRecipes];
    for (NSInteger i = 0; i < recipes.count; i++) {
        FCRecipe *recipe = [recipes objectAtIndex:i];
        [[_arrRecipes objectAtIndex:recipe.weight / 10] addObject:recipe];
    }
    
    _vFilter.delegate = self;
    _tvList.estimatedRowHeight = 0;
    _tvList.estimatedSectionFooterHeight = 0;
    _tvList.estimatedSectionHeaderHeight = 0;
    
    [self reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_isNeedRefresh == YES) {
        _isNeedRefresh = NO;
        [_tvList reloadRowsAtIndexPaths:[_tvList indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)userUpdateFavouriteNotification:(NSNotification *)notifi {
    NSString *vcName = notifi.object;
    if (vcName
        && ![vcName isEqualToString:NSStringFromClass([FCRecipesRootListCell class])]
        && ![vcName isEqualToString:NSStringFromClass([self class])]) {
        _isNeedRefresh = YES;
    }
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrSeletecdFilters.count > 0 ? _arrFilterRecipes.count : _arrRecipes.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 14;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _arrSeletecdFilters.count > 0 ? 148 : 218;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_arrSeletecdFilters.count > 0) {
        FCRecipesRootFilterCell *cell = [FCRecipesRootFilterCell cellWithTableView:tableView andIndexPath:indexPath];
        FCRecipe *recipe = [_arrFilterRecipes objectAtIndex:indexPath.row];
        cell.delegate = self;
        cell.indexPath = indexPath;
        [cell.imgvFood fc_setImageWithName:recipe.imageName_1];
        cell.labTitle.text = recipe.name;
        cell.labTime.text = recipe.time;
        cell.isFavourited = [[FCUser currentUser] isFavouriteRecipe:recipe];
        return cell;
    } else {
        FCRecipesRootListCell *cell = [FCRecipesRootListCell cellWithTableView:tableView andIndexPath:indexPath];
        cell.delegate = self;
        cell.section = indexPath.row;
        [cell makeCellWithData:_arrRecipes[indexPath.row]];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_arrSeletecdFilters.count > 0) {
        FCRecipe *recipe = [_arrFilterRecipes objectAtIndex:indexPath.row];
        FCRecipesDetailViewController *vcRecipesDetail = [FCRecipesDetailViewController viewControllerFromStoryboardWithRecipe:recipe];
        [self.navigationController pushViewController:vcRecipesDetail animated:YES];
    }
}

#pragma mark - FCRecipesRootListCellDelegate
- (void)recipesRootListCell:(FCRecipesRootListCell *)cell didSelectedItemWithIndexPath:(NSIndexPath *)indexPath {
    FCRecipe *recipe = _arrRecipes[indexPath.section][indexPath.row];
    FCRecipesDetailViewController *vcRecipesDetail = [FCRecipesDetailViewController viewControllerFromStoryboardWithRecipe:recipe];
    [self.navigationController pushViewController:vcRecipesDetail animated:YES];
}

#pragma mark - FCRecipesRootFilterCellDelegate
- (void)recipesRootFilterCell:(FCRecipesRootFilterCell *)cell didClickFavouriteActionWithIndexPath:(NSIndexPath *)indexPath {
    FCRecipe *recipe = [_arrFilterRecipes objectAtIndex:indexPath.row];
    FCUser *user = [FCUser currentUser];
    [user updateRecipe:recipe isFavourite:!cell.isFavourited];
    cell.isFavourited = !cell.isFavourited;
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserUpdateFavouriteNotificationKey object:NSStringFromClass([self class])];
}

#pragma mark - FCFilterViewDelegate
- (void)filterView:(FCFilterView *)view didSelectedIndexs:(NSArray<NSNumber *> *)indexs withTitles:(NSArray<NSString *> *)titles {
    [_arrSeletecdFilters removeAllObjects];
    [_arrFilterRecipes removeAllObjects];
    
    [_arrSeletecdFilters addObjectsFromArray:titles];
    if (_arrSeletecdFilters.count > 0) {
        [_arrFilterRecipes addObjectsFromArray:[FCRecipe predicateWithFilters:_arrSeletecdFilters]];
    }
    
    [self reloadData];
}

- (void)reloadData {
    [_tvList reloadData];
    if (_arrSeletecdFilters.count > 0 && _arrFilterRecipes.count < 1) {
        _vNoData.hidden = NO;
        [self.view bringSubviewToFront:_vNoData];
    } else {
        _vNoData.hidden = YES;
        [self.view sendSubviewToBack:_vNoData];
    }
}

@end
