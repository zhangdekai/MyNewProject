//
//  TakePhotoView.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/14.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "TakePhotoView.h"
#import <AVFoundation/AVFoundation.h>

@interface TakePhotoView ()<UIImagePickerControllerDelegate>

@property (nonatomic, strong)       AVCaptureSession            * session;
//AVCaptureSession对象来执行输入设备和输出设备之间的数据传递
@property (nonatomic, strong)       AVCaptureDeviceInput        * videoInput;
//AVCaptureDeviceInput对象是输入流
@property (nonatomic, strong)       AVCaptureStillImageOutput   * stillImageOutput;
//照片输出流对象，当然我的照相机只有拍照功能，所以只需要这个对象就够了
@property (nonatomic, strong)       AVCaptureVideoPreviewLayer  * previewLayer;
//预览图层，来显示照相机拍摄到的画面
@property (nonatomic, strong)       UIButton                    * toggleButton;
//切换前后镜头的按钮
@property (nonatomic, strong)       UIButton                    * shutterButton;
//拍照按钮
//@property (nonatomic, strong)       UIImageView                 * cameraShowView;
//放置预览图层的View


@end

@implementation TakePhotoView

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        [self initCamerView];
        [self setUpCameraLayer];
        [self initialSession];
    
    }
    
    return self;
}


- (void)initCamerView {
    _cameraShowView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 300)];
//    [self addSubview:_cameraShowView];
    _cameraShowView.userInteractionEnabled = YES;
    
    _toggleButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - 40, 280, 30, 20)];
    [_cameraShowView addSubview:_toggleButton];
    [_toggleButton setTitle:@"点" forState:(UIControlStateNormal)];
    [_toggleButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [_toggleButton addTarget:self action:@selector(shutterCamera) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    _shutterButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 280, 30, 20)];
    [_cameraShowView addSubview:_shutterButton];
    [_shutterButton setTitle:@"换" forState:(UIControlStateNormal)];
    [_shutterButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [_shutterButton addTarget:self action:@selector(toggleCamera) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *takeAgain = [[UIButton alloc]initWithFrame:CGRectMake(15, 15, 30, 20)];
    [_cameraShowView addSubview:takeAgain];
    [takeAgain setTitle:@"重" forState:(UIControlStateNormal)];
    [takeAgain setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [takeAgain addTarget:self action:@selector(takeAgain) forControlEvents:(UIControlEventTouchUpInside)];
    
//    [self bringSubviewToFront:_cameraShowView];
}

- (void)takeAgain {
    _cameraShowView.image = nil;
    [self startTakePhoto];
}

- (void)startTakePhoto {
    if (self.session) {
        [self.session startRunning];
    }
}
- (void)stopTakePhoto {
    if (self.session) {
        [self.session stopRunning];
    }
}


- (void) initialSession
{
    //这个方法的执行我放在init方法里了
    self.session = [[AVCaptureSession alloc] init];
    self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self frontCamera] error:nil];
    //[self fronCamera]方法会返回一个AVCaptureDevice对象，因为我初始化时是采用前摄像头，所以这么写，具体的实现方法后面会介绍
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary * outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil];
    //这是输出流的设置参数AVVideoCodecJPEG参数表示以JPEG的图片格式输出图片
    [self.stillImageOutput setOutputSettings:outputSettings];
    
    if ([self.session canAddInput:self.videoInput]) {
        [self.session addInput:self.videoInput];
    }
    if ([self.session canAddOutput:self.stillImageOutput]) {
        [self.session addOutput:self.stillImageOutput];
    }
    
}

- (void) setUpCameraLayer
{
    //if (_cameraAvaible == NO) return;
    
    if (self.previewLayer == nil) {
        self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
        UIView * view = self.cameraShowView;
        CALayer * viewLayer = [view layer];
        //        [viewLayer setMasksToBounds:YES];
        
        //        CGRect bounds = [view bounds];
        self.previewLayer.frame = CGRectMake(0, 0, ScreenWidth, 300);
        //        [self.previewLayer setFrame:bounds];
        [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
        
        [viewLayer insertSublayer:self.previewLayer below:[[viewLayer sublayers] objectAtIndex:0]];
//        [self bringSubviewToFront:_cameraShowView];

    }
}

//这是获取前后摄像头对象的方法

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition) position {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == position) {
            return device;
        }
    }
    return nil;
}


- (AVCaptureDevice *)frontCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionFront];
}

- (AVCaptureDevice *)backCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionBack];
}

//实现切换前后镜头的按钮
- (void)toggleCamera {
    NSUInteger cameraCount = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
    if (cameraCount > 1) {
        NSError *error;
        AVCaptureDeviceInput *newVideoInput;
        AVCaptureDevicePosition position = [[_videoInput device] position];
        
        if (position == AVCaptureDevicePositionBack)
            newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self frontCamera] error:&error];
        else if (position == AVCaptureDevicePositionFront)
            newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self backCamera] error:&error];
        else
            return;
        
        if (newVideoInput != nil) {
            [self.session beginConfiguration];
            [self.session removeInput:self.videoInput];
            if ([self.session canAddInput:newVideoInput]) {
                [self.session addInput:newVideoInput];
                [self setVideoInput:newVideoInput];
            } else {
                [self.session addInput:self.videoInput];
            }
            [self.session commitConfiguration];
        } else if (error) {
            NSLog(@"toggle carema failed, error = %@", error);
        }
    }
}
//这是拍照按钮的方法
- (void) shutterCamera
{
    
    AVCaptureConnection * videoConnection = [self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    if (!videoConnection) {
        NSLog(@"take photo failed!");
        return;
    }
    
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer == NULL) {
            return;
        }
        NSData * imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        UIImage * image = [UIImage imageWithData:imageData];
        _cameraShowView.image = image;
        [self stopTakePhoto];
        
        NSLog(@"image size = %@",NSStringFromCGSize(image.size));
    }];
}


@end
