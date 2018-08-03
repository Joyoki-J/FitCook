//
//  FCSearchScanViewController.m
//  FitCook
//
//  Created by Jay on 2018/8/3.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCSearchScanViewController.h"

@interface FCSearchScanViewController ()

@end

@implementation FCSearchScanViewController

+ (NSString *)storyboardName {
    return @"Search";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Scan a Barcode";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Override
- (UIColor *)navigationBarTitleColor {
    return [UIColor whiteColor];
}

- (UIImage *)navigationBarBackgroundImage {
    return [UIImage fc_imageForDeviceWithImageName:@"navbar_background"];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (UIBarButtonItem *)backButtonItem {
    return [UIBarButtonItem fc_backBarButtonItemWithTarget:self
                                                    action:@selector(popViewController)
                                                 imageName:@"navbarItem_back_white"
                                      highlightedImageName:@"navbarItem_back_white"
                                         selectedImageName:nil];
}

@end
