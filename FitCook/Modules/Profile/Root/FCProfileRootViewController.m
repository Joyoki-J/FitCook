//
//  FCProfileRootViewController.m
//  FitCook
//
//  Created by Joyoki on 2018/7/26.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCProfileRootViewController.h"

@interface FCProfileRootViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgvPicture;


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
        NSLog(@"点击 - Invite Your friends");
    } else if (sender.tag == 101) {
        NSLog(@"点击 - Terms and Conditions");
    } else if (sender.tag == 102) {
        NSLog(@"点击 - Contact Us");
    } else if (sender.tag == 103) {
        NSLog(@"点击 - Logout");
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

@end
