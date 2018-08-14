//
//  FCBaseViewController.h
//  FitCook
//
//  Created by shanshan on 2018/7/16.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCBaseViewController : UIViewController

+ (NSString *)storyboardName;
+ (instancetype)viewControllerFromStoryboard;

- (BOOL)needsHiddenNavigationBar;
- (BOOL)canDragBackFromNavigationController;

- (BOOL)needsCustomBackBarButtonItem;
- (NSArray *)customLeftBarButtonItems;
- (UIBarButtonItem *)backButtonItem;

- (UIImage *)navigationBarBackgroundImage;
- (UIColor *)navigationBarTitleColor;
- (UIFont *)navigationBarTitleFont;

- (void)popViewController;

@end
