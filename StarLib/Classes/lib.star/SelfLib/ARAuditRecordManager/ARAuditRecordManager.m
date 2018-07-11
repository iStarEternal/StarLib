//
//  ARAuditRecordManager.m
//  Canary
//
//  Created by 星星 on 2018/5/7.
//  Copyright © 2018年 litong. All rights reserved.
//

#import "ARAuditRecordManager.h"

@implementation ARAuditRecordManager





/**
 *  返回截取到的图片
 */
+ (UIImage *)imageWithScreenshot {
    NSData *imageData = [self dataWithScreenshotInPNGFormat];
    return [UIImage imageWithData:imageData];
}

/**
 *  截取当前屏幕
 */
+ (NSData *)dataWithScreenshotInPNGFormat {
    CGSize imageSize = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        imageSize = [UIScreen mainScreen].bounds.size;
    }
    else {
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    }
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // UIWindow *window = APP_ROOT_WINDOW;
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft)
        {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        }
        else if (orientation == UIInterfaceOrientationLandscapeRight)
        {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        }
        else
        {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return UIImagePNGRepresentation(image);
}


// 加上被点击的圆点
+ (UIImage *)takeWatermark:(UIImage *)image point:(CGPoint)point {
    
    CGSize new_size = image.size;
    
    CGPoint new_point = CGPointMake(point.x * [UIScreen mainScreen].scale, point.y * [UIScreen mainScreen].scale);
    
    
    UIGraphicsBeginImageContextWithOptions(new_size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextFillRect(context, CGContextGetClipBoundingBox(context));
    
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    
    CGContextSetRGBFillColor(context, 1.0, 0., 0., 1.);
    CGContextFillEllipseInRect(context, CGRectMake(new_point.x-2, new_point.y-2, 4, 4));
    
    CGContextSetRGBFillColor(context, 1.0, 0., 0., 0.8);
    CGContextFillEllipseInRect(context, CGRectMake(new_point.x-20, new_point.y-20, 40, 40));
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


// 保存到沙盒
+ (void)saveImageToDocument:(UIImage *)image name:(NSString *)name {
    
    //拿到图片
    UIImage *imagesave = image;
    // NSString *path_sandox = NSHomeDirectory();
    NSString *path_sandox = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *dPath = [path_sandox stringByAppendingString:@"/test_img_2/"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dPath withIntermediateDirectories:true attributes:NULL error:NULL];
    }
    
    
    // 设置一个图片的存储路径
    NSString *imagePath = [dPath stringByAppendingFormat:@"%@.png", name];
    
    // 把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
    
    // [UIImagePNGRepresentation(imagesave) writeToFile:imagePath atomically:YES];
    
    NSError *error;
    BOOL flag = [UIImagePNGRepresentation(imagesave) writeToFile:imagePath options:(NSDataWritingAtomic) error:&error];
    LogWarning(@"保存图片%@", flag ? @"成功" : @"失败");
}



// 等比缩放图片
+ (UIImage *)image:(UIImage *)image withScale:(CGFloat)scale {
    
    // 等比率缩放
    
    CGRect rect = CGRectMake(0, 0, image.size.width * scale, image.size.height * scale);
    
    UIGraphicsBeginImageContext(rect.size);
    
    [image drawInRect:rect];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}



// MARK: - 页面截图

+ (void)event:(UIEvent *)event {
    
    if (!InAudit) {
        return;
    }
    
    // 创建线程，确保线程对象是独有的。
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("star.save_test_img", DISPATCH_QUEUE_SERIAL);
    });
    
    // 对当前页面截图
    UIImage *img = [self imageWithScreenshot];
    
    // 进入其他线程执行关键步骤
    dispatch_async(queue, ^{
        
        // 非心跳
        if (event) {
            // 获取被点击的页面相对于window的位置
            CGPoint point = [event.allTouches.anyObject locationInView:UIApplication.sharedApplication.delegate.window];
            UIImage *nimg = [self takeWatermark:img point:point];
            
            [self requestEvent:nimg heartbeat:false];
        }
        // 心跳
        else {
            [self requestEvent:img heartbeat:true];
        }
        
    });
}



// MARK: - 定时页面截图

static NSTimer *timer;

+ (void)timingEvent {
    static dispatch_once_t timmer_onceToken;
    dispatch_once(&timmer_onceToken, ^{
        timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timerGo:) userInfo:nil repeats:true];
    });
}

+ (void)timerGo:(NSTimer *)timer {
    if (InAudit) {
        [self event:nil];
    }
    else {
       [timer invalidate], timer = nil;
    }
}







// 上传图片和文本信息
+ (void)requestEvent:(UIImage *)image heartbeat:(BOOL)heartbeat {
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd.HH.mm.ss.SSS";
    NSString *name = [fmt stringFromDate:[NSDate date]];
    
    uint32_t randomv = arc4random_uniform(1000);
    
    NSString *fileName = [NSString stringWithFormat:@"img%@.%d", name, randomv];
    
    // 2018-05-11.10.46.42.123.7896
    
    
    UIImage *scale_img = [self image:image withScale:0.3];
    
    NSData *scale_img_data = UIImageJPEGRepresentation(scale_img, 0.4);  //image/jpeg  image/png
    NSData *base64_scale_img_data = [scale_img_data base64EncodedDataWithOptions:0];
    
    NSString *base64_scale_img = [scale_img_data base64EncodedStringWithOptions:0];
    
    UIImage *temp_img = [UIImage imageWithData:scale_img_data];
    
//    LogSuccess(@"图片原始尺寸 ->%.2fKB, 压缩后尺寸 -> %.2fKB, base64后尺寸 -> %.2fKB, ",
//          image.YINUO_toJPEGData.length / 1024.,
//          scale_img_data.length / 1024.,
//          base64_scale_img_data.length / 1024.
//          );
    
     [self saveImageToDocument:temp_img name:fileName];
    
//    // 上传文本
//    [[AFHTTPSessionManager manager] POST:@"url" parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
//    
//    
//    // 上传图片
//    [[AFHTTPSessionManager manager] POST:@"url" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        
//        // 在此处可以对图片进行尺寸、清晰度压缩。勉强维持在能看到就行
//        // 使用multipart的方式上传图片，会比使用base64数据量更小，不过可以考虑对图片二进制数据进行加密后再传输
//        [formData appendPartWithFileData:scale_img_data name:@"img_file" fileName:fileName mimeType:@"image/jpeg"];
//        
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
    
}



@end
