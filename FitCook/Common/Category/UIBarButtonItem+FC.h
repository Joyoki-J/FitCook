//
//  UIBarButtonItem+FC.h
//  FitCook
//
//  Created by Jay on 2018/7/16.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (FC)

+ (UIBarButtonItem *)fc_barButtonItemWithTarget:(id)target
                                      action:(SEL)selector
                                   imageName:(NSString *)imageName
                        highlightedImageName:(NSString *)highlightedImageName
                           selectedImageName:(NSString *)selectedImageName;

//调整backBarButton 距离左侧间距
+ (UIBarButtonItem *)fc_backBarButtonItemWithTarget:(id)target
                                          action:(SEL)selector
                                       imageName:(NSString *)imageName
                            highlightedImageName:(NSString *)highlightedImageName
                               selectedImageName:(NSString *)selectedImageName;

+ (UIBarButtonItem *)fc_barButtonItemWithTarget:(id)target
                                      action:(SEL)selector
                                       title:(NSString *)title;

@end
