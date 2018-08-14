//
//  UIImageView+FC.h
//  FitCook
//
//  Created by shanshan on 2018/8/11.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (FC)

@property (nonatomic) NSString *fc_imageName;

- (void)fc_setImageWithName:(NSString *)name;

@end
