//
//  FCImageManager.m
//  FitCook
//
//  Created by shanshan on 2018/8/11.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCImageManager.h"

@interface FCImageManager()

@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, strong) NSCache *imageCache;

@end

@implementation FCImageManager

+ (instancetype)shareManager {
    static FCImageManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FCImageManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _queue = dispatch_queue_create("fcimagemanager", DISPATCH_QUEUE_CONCURRENT);
        _imageCache = [[NSCache alloc] init];
    }
    return self;
}

- (void)getImageWithKey:(NSString *)key completion:(void (^)(NSString *key, UIImage *img))completion {
    __block UIImage *image = [_imageCache objectForKey:key];
    if (image && completion) {
        completion(key, image);
    }
    dispatch_async(_queue, ^{
        image = [self loadImageWithKey:key];
        if (image) {
            [self cacheImage:image withKey:key];
            if (completion) {
                completion(key, image);
            }
        }
    });
}

- (void)cacheImage:(UIImage *)image withKey:(NSString *)key {
    [_imageCache setObject:image forKey:key];
}

- (UIImage *)loadImageWithKey:(NSString *)key {
    CGRect rect = [self getRectWithKey:key];
    if (CGRectIsEmpty(rect)) {
        return nil;
    }
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:key ofType:@"png"]];
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextFillRect(context, rect);
    [image drawInRect:rect];
    UIImage* img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (CGRect)getRectWithKey:(NSString *)key {
    if ([key hasSuffix:@"_1"]) {
        return CGRectMake(0, 0, kSCREEN_WIDTH - 28, 134);
    } else if ([key hasSuffix:@"_2"]) {
        return CGRectMake(0, 0, 228, 164);
    } else if ([key hasSuffix:@"_3"]) {
        return CGRectMake(0, 0, 116, 116);
    } else if ([key hasSuffix:@"_4"]) {
        return CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_WIDTH * 7.0 / 10.0);
    } else {
        return CGRectZero;
    }
}

@end
