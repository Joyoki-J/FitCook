//
//  FCSearchRootViewController.m
//  FitCook
//
//  Created by shanshan on 2018/7/26.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCSearchRootViewController.h"
#import "FCSearchFilterViewController.h"
#import "FCSearchScanViewController.h"
#import "FCRecipesDetailViewController.h"
#import "FCSearchRootListCell.h"
#import "FCSearchRootListNoDataCell.h"
#import "FCSearchHeaderView.h"
#import "FCGuideViewController.h"

@interface FCSearchRootViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,FCSearchHeaderViewDelegate,FCSearchFilterViewControllerDelegate,FCSearchRootListCellDelegate,FCSearchScanViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UIView *vHeaderBack;
@property (strong, nonatomic) IBOutlet FCSearchHeaderView *vHeader;
@property (weak, nonatomic) IBOutlet UITableView *tvList;
@property (weak, nonatomic) IBOutlet UIImageView *imgvLogo;

@property (nonatomic, strong) UIView *vFooter;

@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic, assign) BOOL isScrollingToTop;

@property (nonatomic, assign) BOOL isNeedDefaultStatusBar;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutLogoW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutLogoH;

@property (nonatomic, strong) NSMutableArray<FCRecipe *> *arrRecipe;

@property (nonatomic, assign) BOOL isNeedRefresh;

@end

@implementation FCSearchRootViewController

+ (NSString *)storyboardName {
    return @"Search";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _arrRecipe = [NSMutableArray array];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signInNotification:) name:FCSignInNotificationKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutNotification:) name:FCLogoutNotificationKey object:nil];
    
    [self createSubViews];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userUpdateFavouriteNotification:) name:kUserUpdateFavouriteNotificationKey object:nil];
    
    [_vHeader loadFilters];
}

- (void)createSubViews {
    _vFooter = [[UIView alloc] init];
    _vFooter.backgroundColor = [UIColor whiteColor];
    
    _headerHeight = kSCREEN_WIDTH * 0.75 + 109;
    
    _layoutLogoW.constant = kSCREEN_WIDTH * (203.0 / 375.0);
    _layoutLogoH.constant = 169.0 / (375 * 0.75) * (kSCREEN_WIDTH * 0.75);
    
    _tvList.contentInset = UIEdgeInsetsMake(_headerHeight - 175, 0, 0, 0);
    _tvList.estimatedSectionFooterHeight = 0;
    _tvList.estimatedSectionHeaderHeight = 0;
    _tvList.estimatedRowHeight = 0;
    _tvList.scrollsToTop = NO;
    
    _vHeader.frame = CGRectMake(0, _headerHeight - 135, kSCREEN_WIDTH, 135);
    _vHeader.tfSearch.delegate = self;
    _vHeader.delegate = self;
    [self.view addSubview:_vHeader];
    
    _imgvLogo.layer.anchorPoint = CGPointMake(0.5, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_isNeedRefresh == YES) {
        _isNeedRefresh = NO;
        [_tvList reloadRowsAtIndexPaths:[_tvList indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (IS_SS_IPHONE_X && ![FCApp app].hasShowGuideSearch) {
        UIImage *image1 = [UIImage imageNamed:@"icon_guide_search1"];
        FCGuide *guide1 = [[FCGuide alloc] init];
        guide1.index = 0;
        guide1.imageView = [[UIImageView alloc] initWithImage:image1];
        guide1.imageView.frame = CGRectMake((kSCREEN_WIDTH - image1.size.width) / 2.0, (kSCREEN_HEIGHT - image1.size.height) / 2.0, image1.size.width, image1.size.height);
        guide1.imageView.minY = guide1.imageView.minY + 76;
        UIImage *image2 = [UIImage imageNamed:@"icon_guide_search2"];
        FCGuide *guide2 = [[FCGuide alloc] init];
        guide2.index = 1;
        guide2.imageView = [[UIImageView alloc] initWithImage:image2];
        guide2.imageView.frame = CGRectMake((kSCREEN_WIDTH - image2.size.width) / 2.0, (kSCREEN_HEIGHT - image2.size.height) / 2.0, image2.size.width, image2.size.height);
        guide2.imageView.minX = guide2.imageView.minX - 20;
        guide2.imageView.minY = guide2.imageView.minY + 30;
        UIImage *image3 = [UIImage imageNamed:@"icon_guide_search3"];
        FCGuide *guide3 = [[FCGuide alloc] init];
        guide3.index = 2;
        guide3.imageView = [[UIImageView alloc] initWithImage:image3];
        guide3.imageView.frame = CGRectMake((kSCREEN_WIDTH - image3.size.width) / 2.0, (kSCREEN_HEIGHT - image3.size.height) / 2.0, image3.size.width, image3.size.height);
        guide3.imageView.minX = guide3.imageView.minX - 30;
        guide3.imageView.minY = guide3.imageView.minY + 165;
        FCGuideViewController *vc = [[FCGuideViewController alloc] init];
        vc.guides = @[guide1, guide2, guide3];
        [self.tabBarController presentViewController:vc animated:YES completion:^{
            [[RLMRealm defaultRealm] transactionWithBlock:^{
                [FCApp app].hasShowGuideSearch = YES;
            }];
        }];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)userUpdateFavouriteNotification:(NSNotification *)notifi {
    NSString *vcName = notifi.object;
    if (vcName && ![vcName isEqualToString:NSStringFromClass([self class])]) {
        _isNeedRefresh = YES;
    }
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrRecipe.count > 0 ? _arrRecipe.count : 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _arrRecipe.count > 0 ? 148 : kSCREEN_HEIGHT - 175 - kTABBAR_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_arrRecipe.count > 0) {
        FCSearchRootListCell *cell = [FCSearchRootListCell cellWithTableView:tableView andIndexPath:indexPath];
        FCRecipe *mRecipe = [_arrRecipe objectAtIndex:indexPath.row];
        cell.delegate = self;
        cell.indexPath = indexPath;
        [cell.imgvFood fc_setImageWithName:mRecipe.imageName_1];
        cell.labTitle.text = mRecipe.name;
        cell.labTime.text = mRecipe.time;
        cell.isFavourited = [[FCUser currentUser] isFavouriteRecipe:mRecipe];
        return cell;
    } else {
        FCSearchRootListNoDataCell *cell = [FCSearchRootListNoDataCell cellWithTableView:tableView andIndexPath:indexPath];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_arrRecipe.count > 0) {
        FCRecipesDetailViewController *vcRecipesDetail = [FCRecipesDetailViewController viewControllerFromStoryboardWithRecipe:_arrRecipe[indexPath.row]];
        [self.navigationController pushViewController:vcRecipesDetail animated:YES];
    }
}

#pragma mark - FCSearchRootListCellDelegate
- (void)searchRootListCell:(FCSearchRootListCell *)cell didClickFavouriteActionWithIndexPath:(NSIndexPath *)indexPath {
    if (![FCApp app].currentUser) {
        [[FCRootViewController shareViewController] showLoginViewController];
        return;
    }
    FCRecipe *recipe = [_arrRecipe objectAtIndex:indexPath.row];
    FCUser *user = [FCUser currentUser];
    [user updateRecipe:recipe isFavourite:!cell.isFavourited];
    cell.isFavourited = !cell.isFavourited;
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserUpdateFavouriteNotificationKey object:NSStringFromClass([self class])];
}

- (void)reloadData {
    CGPoint p = _tvList.contentOffset;
    [_tvList reloadData];
    if (_tvList.contentSize.height <= (kSCREEN_HEIGHT - 175 - kTABBAR_HEIGHT)) {
        _vFooter.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT - 175 - kTABBAR_HEIGHT - 148 * _arrRecipe.count);
        
        _tvList.tableFooterView = _vFooter;
    } else {
        _vFooter.frame = CGRectMake(0, 0, kSCREEN_WIDTH, 14);
        _tvList.tableFooterView = _vFooter;
    }
    if (p.y > 0) {
        [_tvList setContentOffset:CGPointZero];
    } else {
        [_tvList setContentOffset:p];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
    
    CGFloat y = scrollView.contentOffset.y;
    
    if (y > 0) {
        _vHeader.minY = 40;
    } else if (y < -(_headerHeight - 175)) {
        _vHeader.minY = _headerHeight - 135;
    } else {
        _vHeader.minY = 40 - y;
    }

    CGFloat progress = 1.0 - (_headerHeight - 175 + y) / (_headerHeight - 175);
    if (progress > 1) {
        progress = 1;
    }
    if (progress < 0) {
        progress = 0;
    }
    
    _imgvLogo.layer.transform = CATransform3DMakeScale(progress, progress, 1);
    _vHeader.progress = progress;
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (_isScrollingToTop) {
        _isScrollingToTop = NO;
        [_vHeader.tfSearch becomeFirstResponder];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    CGPoint offset = _tvList.contentOffset;
    [_tvList setContentOffset:offset animated:NO];
    if (offset.y < 0) {
        _isScrollingToTop = YES;
        [_tvList setContentOffset:CGPointZero animated:YES];
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    [self searchRecipes:_vHeader];
    return YES;
}

#pragma mark - FCSearchHeaderViewDelegate
- (void)searchHeaderDidClickScanAction:(FCSearchHeaderView *)vHeader {
    FCSearchScanViewController *vcSearchScan = [FCSearchScanViewController viewControllerFromStoryboard];
    vcSearchScan.deleagte = self;
    [self.navigationController pushViewController:vcSearchScan animated:YES];
}

- (void)searchHeaderDidClickSeeAllFilterAction:(FCSearchHeaderView *)vHeader {
    _isNeedDefaultStatusBar = YES;
    FCSearchFilterViewController *vcSearchFilter = [FCSearchFilterViewController viewControllerWithCustomTransition];
    [vcSearchFilter setSelectedFilters:[_vHeader getFilters]];
    vcSearchFilter.delegate = self;
    [self.tabBarController presentViewController:vcSearchFilter animated:YES completion:nil];
}

- (void)searchHeaderDidSelectedFilter:(FCSearchHeaderView *)vHeader {
    [self searchRecipes:vHeader];
}

- (void)searchRecipes:(FCSearchHeaderView *)vHeader {
    [_arrRecipe removeAllObjects];
    
    NSMutableArray<NSString *> *filterWords = vHeader.keywords;
    NSMutableArray<NSString *> *searchWords = [NSMutableArray array];
    if (vHeader.tfSearch.text && vHeader.tfSearch.text.length > 0) {
        NSArray<NSString *> *words = [vHeader.tfSearch.text componentsSeparatedByString:@" "];
        [words enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [searchWords addObject:[obj lowercaseString]];
        }];
    }
    
    if (filterWords.count < 1 && searchWords.count < 1) {
        [_arrRecipe addObjectsFromArray:[FCRecipe allRecipes]];
    } else if (filterWords.count > 0 && searchWords.count > 0) {
        NSMutableSet *set1 = [NSMutableSet setWithArray:[FCRecipe predicateWithFilters:filterWords]];
        NSMutableSet *set2 = [NSMutableSet setWithArray:[FCRecipe recipesWithKeywords:searchWords]];
        [set1 intersectSet:set2];
        NSMutableArray<FCRecipe *> *recipes = [NSMutableArray array];
        [set1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
            [recipes addObject:obj];
        }];
        [_arrRecipe addObjectsFromArray:[recipes sortedArrayUsingComparator:^NSComparisonResult(FCRecipe * _Nonnull obj1, FCRecipe *  _Nonnull obj2) {
            return obj1.weight > obj2.weight;
        }]];
    } else if (filterWords.count > 0 && searchWords.count < 1) {
        [_arrRecipe addObjectsFromArray:[[FCRecipe predicateWithFilters:filterWords] sortedArrayUsingComparator:^NSComparisonResult(FCRecipe * _Nonnull obj1, FCRecipe *  _Nonnull obj2) {
            return obj1.weight > obj2.weight;
        }]];
    } else if (filterWords.count < 1 && searchWords.count > 0) {
        [_arrRecipe addObjectsFromArray:[[FCRecipe recipesWithKeywords:searchWords] sortedArrayUsingComparator:^NSComparisonResult(FCRecipe * _Nonnull obj1, FCRecipe *  _Nonnull obj2) {
            return obj1.weight > obj2.weight;
        }]];
    }
    
    [self reloadData];
}

#pragma mark - FCSearchScanViewControllerDelegate
- (void)searchScanViewController:(FCSearchScanViewController *)vc didSearchFoodWithName:(NSString *)foodName {
    _vHeader.tfSearch.text = foodName;
    [self searchRecipes:_vHeader];
}

#pragma mark - FCSearchFilterViewControllerDelegate
- (void)searchFilterViewControllerWillClose:(FCSearchFilterViewController *)vc {
    _isNeedDefaultStatusBar = NO;
}

- (void)searchFilterViewController:(FCSearchFilterViewController *)vc didSelectedFilters:(NSArray<NSString *> *)filters {
    [_vHeader setRecipeFilters:filters];
}

- (void)signInNotification:(NSNotification *)noti {
    [_tvList reloadRowsAtIndexPaths:[_tvList indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)logoutNotification:(NSNotification *)noti {
    [_tvList reloadRowsAtIndexPaths:[_tvList indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - Override
- (UIStatusBarStyle)preferredStatusBarStyle {
    return _isNeedDefaultStatusBar ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
}

- (BOOL)needsHiddenNavigationBar {
    return YES;
}

- (UIColor *)navigationBarTitleColor {
    return [UIColor whiteColor];
}

- (UIFont *)navigationBarTitleFont {
    return kFont_20;
}

//- (UIImage *)navigationBarBackgroundImage {
//    return [UIImage fc_imageWithColor:[UIColor clearColor]];
//}

- (UIImage *)navigationBarBackgroundImage {
    return [UIImage fc_imageForDeviceWithImageName:@"navbar_background"];
}

@end
