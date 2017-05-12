//
//  UIImageView+EasyImage.m
//  Images
//
//  Created by wangjufan on 12/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import "UIImageView+EasyImage.h"

#import "UIImage+EasyImage.h"
#import <objc/runtime.h>

#import "EasyCacheManager.h"

#import "NSObject+Dispatch.h"

#import "EasyDownloadProtocol.h"

@implementation UIImageView(EasyImage)


-(void) easyImageWithPara:(EasyImageParas *) paras{
    __weak typeof(self) wself = self;
    @synchronized (wself) {
        [wself easyImageCancel];
        paras.imageView = wself;
        objc_setAssociatedObject(wself, @"EasyImage_URL", paras, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [paras.downloader easyDownload:paras];
    }
}

-(void) easyImageCancel{
    __weak typeof(self) wself = self;
    @synchronized (wself) {
        EasyImageParas * easyParas = objc_getAssociatedObject(wself, @"EasyImage_URL");
        if (easyParas) {
            if (easyParas.autoCancel && !easyParas.loading) {
                [easyParas.downloader easyCancelDownload:easyParas];
                objc_setAssociatedObject(wself, @"EasyImage_URL", nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                if (easyParas) {
                    easyParas.recycleBlock(easyParas);
                }
            }
        }
    }
}

//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////

- (void) easyGifInMainbundleForName:(NSString *)name {
    CGFloat scale = [UIScreen mainScreen].scale;
    NSData *data = nil;
    NSString * path = nil;
    if (scale > 2.0f) {
        path = [[NSBundle mainBundle] pathForResource:[name stringByAppendingString:@"@3x"] ofType:@"gif"];
        data = [NSData dataWithContentsOfFile:path];
    }
    if (scale > 1.0f && data == nil) {
        path = [[NSBundle mainBundle] pathForResource:[name stringByAppendingString:@"@2x"] ofType:@"gif"];
        data = [NSData dataWithContentsOfFile:path];
    }
    if (data == nil) {
        path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        data = [NSData dataWithContentsOfFile:path];
    }
    UIImage * image = [UIImage easyGifWithData:data];
    self.image = image;
}
- (void) easyPngInMainbundleForName:(NSString *) name{
    CGFloat scale = [UIScreen mainScreen].scale;
    NSData *data = nil;
    NSString * path = nil;
    if (scale > 2.0f) {
        path = [[NSBundle mainBundle] pathForResource:[name stringByAppendingString:@"@3x"] ofType:@"png"];
        data = [NSData dataWithContentsOfFile:path];
    }
    if (scale > 1.0f && data == nil) {
        path = [[NSBundle mainBundle] pathForResource:[name stringByAppendingString:@"@2x"] ofType:@"png"];
        data = [NSData dataWithContentsOfFile:path];
    }
    if (data == nil) {
        path = [[NSBundle mainBundle] pathForResource:name ofType:@"png"];
        data = [NSData dataWithContentsOfFile:path];
    }
    UIImage * image = [UIImage imageWithData:data];
    self.image = image;
}

@end


