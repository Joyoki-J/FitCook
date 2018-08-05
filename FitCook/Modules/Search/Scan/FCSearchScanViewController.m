//
//  FCSearchScanViewController.m
//  FitCook
//
//  Created by Jay on 2018/8/3.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCSearchScanViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface FCSearchScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *vMid;
@property (weak, nonatomic) IBOutlet UIImageView *scanImageView;

@property (nonatomic, assign) BOOL upOrdown;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) AVCaptureSession * session;
@property (nonatomic, assign) BOOL isSuccess;

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *preview;

@end

@implementation FCSearchScanViewController

+ (NSString *)storyboardName {
    return @"Search";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Scan a Barcode";
    
    _upOrdown = NO;
    
    self.scanImageView.frame = CGRectMake((self.view.width - 202) / 2.0 + 21.0, (self.view.height - 202) / 2.0 + 19.0, 160, 10);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.translucent = YES;
    [self startCamera];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.translucent = NO; 
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self releaseResource];
}

- (void)startCamera {
    _isSuccess = NO;
    if (!_preview) {
        [self setUpCamera];
    }
    if (!_timer)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(scanAnimation) userInfo:nil repeats:YES];
    }
}

- (void)scanAnimation {
    int length = 164;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.upOrdown == NO)
        {
            self.scanImageView.minY += 1;
            if (self.scanImageView.maxY - ((self.view.height - 202) / 2.0 + 19.0) == length)
            {
                self.upOrdown = YES;
            }
        } else {
            self.scanImageView.minY -= 1;
            if (self.scanImageView.minY == (self.view.height - 202) / 2.0 + 19.0) {
                self.upOrdown = NO;
            }
        }
    });
}

-(void)releaseResource
{
    [_session stopRunning];
    _session = nil;
    [_preview removeFromSuperlayer];
    [_timer invalidate];
    _timer = nil;
}

- (void)setUpCamera {
   
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError *error;
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (error != nil && input == nil)
    {
        return;
    }
    
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc] init];
    
    
    CGFloat x = ((self.view.height - 202) / 2.0) / self.view.height;
    CGFloat y = ((self.view.width - 202) / 2.0 ) / self.view.width;
    CGFloat w = 202 / self.view.height;
    CGFloat h = 202 / self.view.width;
    output.rectOfInterest=CGRectMake(x, y, w, h);
    
   
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    
    _session = [[AVCaptureSession alloc]init];
    
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    if ([_session canAddInput:input])
    {
        [_session addInput:input];
    }
    if ([_session canAddOutput:output])
    {
        [_session addOutput:output];
    }
    
    output.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    _preview = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame = [UIScreen mainScreen].bounds;
    [self.view.layer insertSublayer:_preview atIndex:0];
    
    [_session startRunning];
}


-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (metadataObjects != nil && metadataObjects.count > 0 && !self.isSuccess) {
            self.isSuccess = YES;
            AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects firstObject ];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Scan" message:metadataObject.stringValue preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.isSuccess = NO;
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        }
    });
}

#pragma mark - Override
- (UIColor *)navigationBarTitleColor {
    return [UIColor whiteColor];
}

- (UIImage *)navigationBarBackgroundImage {
    return [UIImage fc_imageForDeviceWithImageName:@"navbar_background"];
}

//- (UIImage *)navigationBarBackgroundImage {
//    return [UIImage fc_imageWithColor:[UIColor clearColor]];
//}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (UIBarButtonItem *)backButtonItem {
    return [UIBarButtonItem fc_backBarButtonItemWithTarget:self
                                                    action:@selector(popViewController)
                                                 imageName:@"navbarItem_back_white"
                                      highlightedImageName:@"navbarItem_back_white"
                                         selectedImageName:nil];
}

@end
