//
//  FCUIManager.h
//  FitCook
//
//  Created by Jay on 2018/7/16.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a/100.f]
#define RGB(r,g,b) RGBA(r,g,b,100.f)

#define COLOR_MAIN           RGB(221.0f,64.0f,59.0f)
#define COLOR_BARITEM_GRAY   RGB(245.0f,165.0f,162.0f)
#define COLOR_DefaultTittle  RGB(51, 51, 51)

#define kFCFont(size)       [FCUIManager fontOfSize:(size) bold:NO]
#define kFCBoldFont(size)   [FCUIManager fontOfSize:(size) bold:YES]

#define kFCFont_21 kFCFont(21)
#define kFCFont_20 kFCFont(20)
#define kFCFont_19 kFCFont(19)
#define kFCFont_18 kFCFont(18)
#define kFCFont_17 kFCFont(17)
#define kFCFont_16 kFCFont(16)
#define kFCFont_15 kFCFont(15)
#define kFCFont_14 kFCFont(14)
#define kFCFont_13 kFCFont(13)
#define kFCFont_12 kFCFont(12)
#define kFCFont_11 kFCFont(11)
#define kFCFont_10 kFCFont(10)

typedef NS_ENUM(NSInteger, FCScreenSize) {
    FCS_None,
    //2x
    FCS_ScreenSize_3_5, //3.5, 4,4s
    FCS_ScreenSize_4_0, //4.0, 5,5s,5e
    FCS_ScreenSize_4_7, //4.7, 6,6s,7
    //3x
    FCS_ScreenSize_5_5, //5.5, 6p,6sp,7p
    FCS_ScreenSize_5_8, //5.8, x
};

#define kCurrent_SS [FCUIManager currentScreenSize]

#define IS_SS_IPHONE_4   kCurrent_SS == FCS_ScreenSize_3_5  //iphone 4,4s
#define IS_SS_IPHONE_5   kCurrent_SS == FCS_ScreenSize_4_0  //iphone 5,5s,5e
#define IS_SS_IPHONE_6   kCurrent_SS == FCS_ScreenSize_4_7  //iphone 6,6s,7
#define IS_SS_IPHONE_P   kCurrent_SS == FCS_ScreenSize_5_5  //iphone 6p,6sp,7p
#define IS_SS_IPHONE_X   kCurrent_SS == FCS_ScreenSize_5_8  //iphone x

@interface FCUIManager : NSObject

+ (FCScreenSize)currentScreenSize;

+ (UIFont *)fontOfSize:(CGFloat)size bold:(BOOL)bold;

@end
