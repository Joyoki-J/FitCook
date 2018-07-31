//
//  UIImage+FC.m
//  FitCook
//
//  Created by Joyoki on 2018/7/26.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "UIImage+FC.h"

@implementation UIImage (FC)

+ (UIImage *)fc_imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)fc_imageForDeviceWithImageName:(NSString *)imageName {
    
    NSString *realImageName = imageName;
    
    if (IS_SS_IPHONE_X) {
        realImageName = [NSString stringWithFormat:@"%@_iphoneX", realImageName];
    } else if (IS_SS_IPHONE_P) {
        realImageName = [NSString stringWithFormat:@"%@_iphoneP", realImageName];
    } else if (IS_SS_IPHONE_6) {
        realImageName = [NSString stringWithFormat:@"%@_iphone6", realImageName];
    } else if (IS_SS_IPHONE_5) {
        realImageName = [NSString stringWithFormat:@"%@_iphone5", realImageName];
    } else if (IS_SS_IPHONE_4) {
        realImageName = [NSString stringWithFormat:@"%@_iphone4", realImageName];
    }
    
    return [self imageNamed:realImageName];
}

@end
