//
//  UIBarButtonItem+FC.m
//  FitCook
//
//  Created by Jay on 2018/7/16.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "UIBarButtonItem+FC.h"

@implementation UIBarButtonItem (FC)

+ (UIBarButtonItem *)fc_barButtonItemWithTarget:(id)target
                                      action:(SEL)selector
                                   imageName:(NSString *)imageName
                        highlightedImageName:(NSString *)highlightedImageName
                           selectedImageName:(NSString *)selectedImageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setImage:image forState:UIControlStateNormal];
    if (highlightedImageName) {
        [button setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    }
    if (selectedImageName) {
        [button setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    }
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)fc_backBarButtonItemWithTarget:(id)target
                                          action:(SEL)selector
                                       imageName:(NSString *)imageName
                            highlightedImageName:(NSString *)highlightedImageName
                               selectedImageName:(NSString *)selectedImageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -11.0f, 0, 0);
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setImage:image forState:UIControlStateNormal];
    if (highlightedImageName) {
        [button setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    }
    if (selectedImageName) {
        [button setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    }
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)fc_barButtonItemWithTarget:(id)target
                                      action:(SEL)selector
                                       title:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = kFont_16;
    button.titleLabel.textAlignment = NSTextAlignmentRight;
    [button setTitleColor:kCOLOR_GRAY_BARITEM forState:UIControlStateDisabled];
    [button sizeToFit];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
