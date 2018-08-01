//
//  UIImage+FC.h
//  FitCook
//
//  Created by Joyoki on 2018/7/26.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FC)

+ (UIImage *)fc_imageWithColor:(UIColor *)color;

+ (UIImage *)fc_imageForDeviceWithImageName:(NSString *)imageName;

+ (UIImage *)fc_imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage
                                          targetSize:(CGSize)targetSize;
+ (UIImage *)fc_imageByScalingToOriginalSize:(UIImage *)sourceImage;
+ (UIImage *)fc_imageByScalingToMaxSize:(UIImage *)sourceImage;
+ (UIImage *)fc_crop:(UIImage*)theImage;

- (UIImage *)fc_fixOrientation;

+ (UIImage *)fc_resizedImage:(NSString *)name;

@end
