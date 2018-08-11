//
//  UIImageView+FC.h
//  FitCook
//
//  Created by Joyoki on 2018/8/11.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (FC)

@property (nonatomic) NSString *fc_imageName;

- (void)fc_setImageWithName:(NSString *)name;

@end
