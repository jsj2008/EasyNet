//
//  UIImageView+EasyImage.m
//  Images
//
//  Created by wangjufan on 12/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import "UIImageView+EasyImage.h"

#import <objc/runtime.h>

#import "UIImage+EasyImage.h"
#import "NSObject+Dispatch.h"

#import "EasyCacheManager.h"
#import "EasyDownloadProtocol.h"
#import "EasyInnerImageProtocol.h"
#import "EasyImageProtocol.h"

#define EasyImage_URL @"EasyImage_URL"

@implementation UIImageView(EasyImage)

-(void) easyImageWithPara:(id<EasyImageProtocol>) para{
    __weak typeof(self) wself = self;
    
    @synchronized (wself) {
        [wself easyImageCancel];
        para.owner = wself;
        objc_setAssociatedObject(wself, EasyImage_URL, para, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [para.downloader easyDownload:para];
    }
}

-(void) easyImageCancel{
    __weak typeof(self) wself = self;
        @synchronized (wself) {
        id<EasyInnerImageProtocol> para = objc_getAssociatedObject(wself, EasyImage_URL);
        if (para) {
            if (para.autoCancel) {
                [para setHasCanceled:YES];
                [para.downloader easyCancelDownload:para];
                objc_setAssociatedObject(wself, EasyImage_URL, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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


