//
//  FCSearchRootViewController.m
//  FitCook
//
//  Created by Joyoki on 2018/7/26.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCSearchRootViewController.h"
#import "FCSearchFilterViewController.h"
#import "FCSearchScanViewController.h"
#import "FCSearchRootListCell.h"
#import "FCSearchHeaderView.h"

@interface FCSearchRootViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIView *vHeaderBack;
@property (strong, nonatomic) IBOutlet FCSearchHeaderView *vHeader;
@property (weak, nonatomic) IBOutlet UITableView *tvList;
@property (weak, nonatomic) IBOutlet UIImageView *imgvLogo;

@property (nonatomic, assign) CGFloat headerHeight;

@end

@implementation FCSearchRootViewController

+ (NSString *)storyboardName {
    return @"Search";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSubViews];
}

- (void)createSubViews {
    _headerHeight = kSCREEN_WIDTH * 0.75 + 123;
    
    _tvList.contentInset = UIEdgeInsetsMake(_headerHeight - 189, 0, 0, 0);
    _tvList.estimatedSectionFooterHeight = 0;
    _tvList.estimatedSectionHeaderHeight = 0;
    _tvList.estimatedRowHeight = 0;
    _tvList.scrollsToTop = NO;
    
    _vHeader.frame = CGRectMake(0, _headerHeight - 149, kSCREEN_WIDTH, 149);
    _vHeader.tfSearch.delegate = self;
    [self.view addSubview:_vHeader];
    
    _imgvLogo.layer.anchorPoint = CGPointMake(0.5, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.view endEditing:YES];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 148;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FCSearchRootListCell *cell = [FCSearchRootListCell cellWithTableView:tableView andIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FCSearchScanViewController *vcSearchScan = [FCSearchScanViewController viewControllerFromStoryboard];
    [self.navigationController pushViewController:vcSearchScan animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
    
    CGFloat y = scrollView.contentOffset.y;
    
    if (y > 0) {
        _vHeader.minY = 40;
    } else if (y < -(_headerHeight - 189)) {
        _vHeader.minY = _headerHeight - 149;
    } else {
        _vHeader.minY = 40 - y;
    }

    CGFloat progress = 1.0 - (_headerHeight - 189 + y) / (_headerHeight - 189);
    if (progress > 1) {
        progress = 1;
    }
    if (progress < 0) {
        progress = 0;
    }
    
    _imgvLogo.layer.transform = CATransform3DMakeScale(progress, progress, 1);
    _vHeader.progress = progress;
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (_tvList.contentOffset.y < 0) {
        [_tvList setContentOffset:CGPointZero animated:YES];
        return NO;
    }
    return YES;
}

#pragma mark - Override
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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
