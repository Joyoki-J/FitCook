//
//  FCBaseViewController.h
//  FitCook
//
//  Created by Jay on 2018/7/16.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCBaseViewController : UIViewController

+ (NSString *)storyboardName;
+ (instancetype)viewControllerFromStoryboard;

- (BOOL)needsHiddenNavigationBar;

- (BOOL)needsCustomBackBarButtonItem;
- (NSArray *)customLeftBarButtonItems;
- (UIBarButtonItem *)backButtonItem;

- (UIImage *)navigationBarBackgroundImage;
- (UIColor *)navigationBarTitleColor;
- (UIFont *)navigationBarTitleFont;

- (void)popViewController;

@end
