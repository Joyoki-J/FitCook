//
//  FCProfileRootViewController.m
//  FitCook
//
//  Created by Joyoki on 2018/7/26.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCProfileRootViewController.h"
#import "FCTermsConditionsViewController.h"
#import "FCSignInViewController.h"
#import <MessageUI/MessageUI.h>

#define kCompressibilityFactor 1280.0 / [UIScreen mainScreen].scale
@interface FCProfileRootViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgvPicture;
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labEmail;


// Constraints
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutContentHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutSpace1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutSpace2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutSpace3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutSpace4;


@end

@implementation FCProfileRootViewController

+ (NSString *)storyboardName {
    return @"Profile";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imgvPicture.layer.cornerRadius = 4.f;
    _imgvPicture.clipsToBounds = YES;
    
    FCUser *user = [FCUser currentUser];
    _labName.text = user.name;
    _labEmail.text = user.email;
    if (user.image) {
        _imgvPicture.image = [UIImage imageWithData:user.image];
    }
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    _layoutContentHeight.constant = kSCREEN_HEIGHT - kNAVBAR_HEIGHT - kTABBAR_HEIGHT;
    CGFloat space = (_layoutContentHeight.constant - 300) / 5.0;
    space = space > 40 ? 40 : space;
    _layoutSpace1.constant = space;
    _layoutSpace2.constant = space;
    _layoutSpace3.constant = space;
    _layoutSpace4.constant = space;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickAction:(UIButton *)sender {
    if (sender.tag == 99) {
        [self showPickPhotoAlert];
    } else if (sender.tag == 100) {
        [self shared];
    } else if (sender.tag == 101) {
        FCTermsConditionsViewController *vcTermsConditions = [FCTermsConditionsViewController viewControllerFromStoryboard];
        [self.navigationController pushViewController:vcTermsConditions animated:YES];
    } else if (sender.tag == 102) {
        if ([MFMailComposeViewController canSendMail]) {
            [self sendEmail];
        }else{
            //给出提示,设备未开启邮件服务
        }
    } else if (sender.tag == 103) {
        [FCUser logoutCurrentUser];
        [[NSNotificationCenter defaultCenter] postNotificationName:FCLogoutNotificationKey object:nil];
        [FCToast showText:@"You have been logged out."];
    }
    
}

- (void)showPickPhotoAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"Take a photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypeCamera];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Choose a photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showImagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = sourceType;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *image = [UIImage fc_imageByScalingToOriginalSize:[info objectForKey:UIImagePickerControllerEditedImage]];
        if(picker.sourceType == UIImagePickerControllerSourceTypeCamera){
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
        //对图片进行旋转
        UIImage *orientationImage = [image fc_fixOrientation];
        UIImage *scaleImage = [UIImage fc_imageByScalingAndCroppingForSourceImage:orientationImage targetSize:CGSizeMake(210, 210)];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [picker dismissViewControllerAnimated:YES completion:^{
                [self uploadHeadImage:scaleImage];
            }];
        });
    });
}

- (void)uploadHeadImage:(UIImage *)image {
    _imgvPicture.image = image;
    [[FCUser currentUser] updateUserImage:UIImagePNGRepresentation(image)];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
{
    if (!error){
        NSLog(@"save image success");
    }
    else{
        NSLog(@"save image fail");
    }
}

- (void)shared {
//    NSString *textToShare = @"FitCook";
//    NSURL *urlToShare = [NSURL URLWithString:@"https://itunes.apple.com/us/app/fitcook/id1420594493"];
//    NSArray *activityItems = @[textToShare,urlToShare];
    UIImage *image = [UIImage imageNamed:@"foot_photo3"];
    NSArray *activityItems = @[[self getJPEGImagerImg:image]];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypePrint,
                                         UIActivityTypeCopyToPasteboard,
                                         UIActivityTypeAssignToContact,
                                         UIActivityTypeSaveToCameraRoll,
                                         UIActivityTypeAddToReadingList,
                                         UIActivityTypePostToFlickr,
                                         UIActivityTypePostToVimeo,
                                         UIActivityTypeOpenInIBooks];
    [self presentViewController:activityVC animated:YES completion:nil];
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed) {
            NSLog(@"completed");
        } else  {
            NSLog(@"cancled");
        }
    };
}

- (UIImage *)getJPEGImagerImg:(UIImage *)image{
    CGFloat oldImg_WID = image.size.width;
    CGFloat oldImg_HEI = image.size.height;
    //CGFloat aspectRatio = oldImg_WID/oldImg_HEI;
    if(oldImg_WID > kCompressibilityFactor || oldImg_HEI > kCompressibilityFactor){
        if(oldImg_WID > oldImg_HEI){
            oldImg_HEI = (kCompressibilityFactor * oldImg_HEI)/oldImg_WID;
            oldImg_WID = kCompressibilityFactor;
        }else{
            oldImg_WID = (kCompressibilityFactor * oldImg_WID)/oldImg_HEI;
            oldImg_HEI = kCompressibilityFactor;
        }
    }
    UIImage *newImg = [self imageWithImage:image scaledToSize:CGSizeMake(oldImg_WID, oldImg_HEI)];
    return newImg;
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContextWithOptions(newSize, NO, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)sendEmail {
    
    MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
    
    [mailCompose setMailComposeDelegate:self];
    
    [mailCompose setToRecipients:@[@"sswenj33@gmail.com"]];
    
    [mailCompose setSubject:@"Hello FitCook"];
    
    [self presentViewController:mailCompose animated:YES completion:nil];

}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail send canceled: 用户取消编辑");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: 用户保存邮件");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent: 用户点击发送");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail send errored: %@ : 用户尝试保存或发送邮件失败", [error localizedDescription]);
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
