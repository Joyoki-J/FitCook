//
//  FCShoppingRootViewController.m
//  FitCook
//
//  Created by Joyoki on 2018/7/26.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCShoppingRootViewController.h"
#import "FCShoppingRootRecipesCell.h"
#import "FCShoppingRootFoodsCell.h"
#import "FCShoppingListViewController.h"

@interface FCShoppingRootViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) BOOL isFoodsStyle;
@property (nonatomic, strong) UIButton *btnRightItem;

@property (weak, nonatomic) IBOutlet UITableView *tvList;

@property (nonatomic, strong) NSMutableArray *arrRecipes;
@property (nonatomic, strong) NSMutableArray *arrFoods;

@end

@implementation FCShoppingRootViewController

+ (NSString *)storyboardName {
    return @"Shopping";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _arrRecipes = [NSMutableArray array];
    _arrFoods   = [NSMutableArray array];
    
    [_arrRecipes addObjectsFromArray:@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@""]];
    [_arrFoods addObjectsFromArray:@[@"Avocado",@"Spaghetti",@"Olive Oil",@"Salt",@"Milk"]];
    
    _tvList.estimatedSectionFooterHeight = 0;
    _tvList.estimatedSectionFooterHeight = 0;
    
    [self addRightBarButtonItem];
}

- (void)addRightBarButtonItem {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 22, 22, 22);
    [button setImage:[UIImage imageNamed:@"navbarItem_liststyle_recipes"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onClickRightAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    _btnRightItem = button;
}

- (void)onClickRightAction:(UIButton *)sender {
    _isFoodsStyle = !_isFoodsStyle;
    [_btnRightItem setImage:_isFoodsStyle ? [UIImage imageNamed:@"navbarItem_liststyle_foods"] : [UIImage imageNamed:@"navbarItem_liststyle_recipes"] forState:UIControlStateNormal];
    [_tvList reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _isFoodsStyle ? _arrFoods.count : _arrRecipes.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _isFoodsStyle ? 42.0 : 116.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return _isFoodsStyle ? CGFLOAT_MIN : 14.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isFoodsStyle) {
        FCShoppingRootFoodsCell *cell = [FCShoppingRootFoodsCell cellWithTableView:tableView andIndexPath:indexPath];
        cell.labFoodName.text = _arrFoods[indexPath.section];
        return cell;
    } else {
        FCShoppingRootRecipesCell *cell = [FCShoppingRootRecipesCell cellWithTableView:tableView andIndexPath:indexPath];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isFoodsStyle) {
        FCShoppingRootFoodsCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.isSelected = !cell.isSelected;
    } else {
        FCShoppingListViewController *vcShoppingList = [FCShoppingListViewController viewControllerFromStoryboard];
        [self.navigationController pushViewController:vcShoppingList animated:YES];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return !_isFoodsStyle;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!_isFoodsStyle && editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView endEditing:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.arrRecipes removeObjectAtIndex:indexPath.section];
            [tableView reloadData];
        });
    }
}

@end
