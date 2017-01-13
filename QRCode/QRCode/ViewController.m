//
//  ViewController.m
//  QRCode
//
//  Created by 边雷 on 17/1/13.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<AVCaptureMetadataOutputObjectsDelegate>
// 输入设备  摄像头
@property(nonatomic, strong) AVCaptureDeviceInput *input;
// 输出设备  二维码算法生成的元数据
@property(nonatomic, strong) AVCaptureMetadataOutput *output;
// 会话  管理输入和输出设备
@property(nonatomic, strong) AVCaptureSession *session;
// 预览视图  layer
@property(nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. 输入设备  摄像头
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo] error:nil];
    
    // 2. 输出设备  二维码算法生成的元数据
    self.output = [[AVCaptureMetadataOutput alloc] init];
    
    // 设置输出设备的代理    获取数据
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 3. 会话  管理输入和输出设备
    self.session = [[AVCaptureSession alloc]init];
    
    // 添加输入&输出设备
    [self.session addInput:self.input];
    [self.session addOutput:self.output];
    
    // 输出设备的类型必须在输出设备添加到会话以后才能设置    AVMetadataObjectTypeQRCode二维码算法 iOS6内置
    self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    
    // 4. 预览视图layer
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    [self.view.layer addSublayer:self.previewLayer];
    
    // 设置尺寸
    self.previewLayer.frame = [UIScreen mainScreen].bounds;
    
    // 开始会话
    [self.session startRunning];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

// 已经生成元数据后调用   captureOutput 输出设备   metadataObjects 转出的元数据   connection连接
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    for (AVMetadataMachineReadableCodeObject *obj in metadataObjects) {
        
        NSLog(@"%@", obj.stringValue);
        
        
    }
}


@end
