//
//  FCShoppingListViewController.m
//  FitCook
//
//  Created by shanshan on 2018/7/31.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCShoppingListViewController.h"
#import "FCRecipesDetailViewController.h"
#import "FCShoppingRootFoodsCell.h"

@interface FCShoppingListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tvList;

@property (nonatomic, strong) NSMutableArray *arrShopingFoods;
@property (nonatomic, strong) UIImageView *imgvHeader;

@end

@implementation FCShoppingListViewController

+ (NSString *)storyboardName {
    return @"Shopping";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Shopping List";
    
    _arrShopingFoods = [NSMutableArray array];
    [_arrShopingFoods addObjectsFromArray:@[@"Avocado",@"Spaghetti",@"Olive Oil",@"Salt",@"Milk"]];
    
    _tvList.tableHeaderView = [self createHeaderView];
    _imgvHeader.image = [UIImage imageNamed:@"foot_photo1"];
}

- (UIView *)createHeaderView {
    UIView *vHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 21.0 / 50.0 * (kSCREEN_WIDTH - 30.0))];
    vHeader.backgroundColor = [UIColor whiteColor];
    
    _imgvHeader = [[UIImageView alloc] init];
    [vHeader addSubview:_imgvHeader];
    
    UIView *vMask = [[UIView alloc] init];
    vMask.backgroundColor = RGBA(0, 0, 0, 12);
    [vHeader addSubview:vMask];
    
    UIImageView *imgvArrow = [[UIImageView alloc] init];
    imgvArrow.image = [UIImage imageNamed:@"icon_shopping_arrow_white"];
    [vMask addSubview:imgvArrow];
    
    UILabel *labToRecipes = [[UILabel alloc] init];
    labToRecipes.text = @"back to recipe";
    labToRecipes.textColor = [UIColor whiteColor];
    labToRecipes.textAlignment = NSTextAlignmentRight;
    labToRecipes.font = kFont_14;
    [vMask addSubview:labToRecipes];
    
    [_imgvHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.leading.mas_equalTo(15);
        make.trailing.mas_equalTo(-15);
    }];
    
    [vMask mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.leading.mas_equalTo(15);
        make.trailing.mas_equalTo(-15);
    }];
    
    [imgvArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(13);
        make.trailing.mas_equalTo(-10);
        make.bottom.mas_equalTo(-11);
    }];
    
    [labToRecipes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(imgvArrow.mas_leading).offset(-4);
        make.centerY.equalTo(imgvArrow.mas_centerY);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickHeaderAction:)];
    [vMask addGestureRecognizer:tap];
    
    return vHeader;
}

- (void)onClickHeaderAction:(UITapGestureRecognizer *)tap {
    FCRecipesDetailViewController *vcRecipesDetail = [FCRecipesDetailViewController viewControllerFromStoryboard];
    [self.navigationController pushViewController:vcRecipesDetail animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrShopingFoods.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 42.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FCShoppingRootFoodsCell *cell = [FCShoppingRootFoodsCell cellWithTableView:tableView andIndexPath:indexPath];
    cell.labFoodName.text = _arrShopingFoods[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FCShoppingRootFoodsCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.isSelected = !cell.isSelected;
}

@end
