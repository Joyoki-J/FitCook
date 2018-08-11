//
//  UIImageView+FC.m
//  FitCook
//
//  Created by Joyoki on 2018/8/11.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "UIImageView+FC.h"
#import "FCImageManager.h"
#import <objc/runtime.h>

#define dispatch_safe_async(block) \
    if ([[NSThread currentThread] isMainThread]) { \
        block(); \
    } else { \
        dispatch_async(dispatch_get_main_queue(), ^{ block(); }); \
    }

static char FCImageName;

@implementation UIImageView (FC)

- (void)fc_setImageWithName:(NSString *)name {
    self.fc_imageName = name;
    [[FCImageManager shareManager] getImageWithKey:name completion:^(NSString *key, UIImage *img) {
        dispatch_safe_async(^ {
            if ([self.fc_imageName isEqualToString:key]) {
                self.image = img;
            }
        });
    }];
    
}

- (void)setFc_imageName:(NSString *)fc_imageName {
    objc_setAssociatedObject(self, &FCImageName, fc_imageName, OBJC_ASSOCIATION_COPY);
}

- (NSString *)fc_imageName {
    return objc_getAssociatedObject(self, &FCImageName);
}

@end
