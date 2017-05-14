//
//  UIImage+Header.m
//  Images
//
//  Created by wangjufan on 13/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import "UIImage+Header.h"

#import "UIImage+EasyImage.h"
#import <ImageIO/ImageIO.h>


@implementation UIImage(Header)


+(CGSize) easyImageSizeOfPNG:(NSData *) data {
    int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
    [data getBytes:&w1 range:NSMakeRange(0, 1)];
    [data getBytes:&w2 range:NSMakeRange(1, 1)];
    [data getBytes:&w3 range:NSMakeRange(2, 1)];
    [data getBytes:&w4 range:NSMakeRange(3, 1)];
    int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
    
    int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
    [data getBytes:&h1 range:NSMakeRange(4, 1)];
    [data getBytes:&h2 range:NSMakeRange(5, 1)];
    [data getBytes:&h3 range:NSMakeRange(6, 1)];
    [data getBytes:&h4 range:NSMakeRange(7, 1)];
    int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
    
    return CGSizeMake(w, h);
}
+(CGSize) easyImageSizeOfJPG:(NSData *) data {
    
//    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
//    }
    
    short word = 0x0;
    [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
    if (word == 0xdb) {
        [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
        
        if (word == 0xdb) {// 两个DQT字段
            short w1 = 0, w2 = 0;
            [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
            [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
            short w = (w1 << 8) + w2;
            short h1 = 0, h2 = 0;
            [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
            [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
            short h = (h1 << 8) + h2;
            return CGSizeMake(w, h);
        } else {// 一个DQT字段
            short w1 = 0, w2 = 0;
            [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
            [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
            short w = (w1 << 8) + w2;
            short h1 = 0, h2 = 0;
            [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
            [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
            short h = (h1 << 8) + h2;
            return CGSizeMake(w, h);
        }
    } else {
        return CGSizeZero;
    }
}

+(CGSize) easyImageSizeForHeadData:(NSData *) data{
    NSString * type = [UIImage easyImageFormatForData:data];
    if ([[type lowercaseString] containsString:@".png"]) {
        return [self easyImageSizeOfPNG:data];
    }
    if ([[type lowercaseString] containsString:@".jpg"]) {
        return [self easyImageSizeOfJPG:data];
    }
    return CGSizeZero;
}

+ (NSString *) easyImageFormatForData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"image/jpeg";
        case 0x89:
            return @"image/png";
        case 0x47:
            return @"image/gif";
        case 0x49:
        case 0x4D:
            return @"image/tiff";
        case 0x52:// R as RIFF for WEBP
            return nil;
    }
    return nil;
}
+(UIImageOrientation)easyImageOrientationForData:(NSData *)imageData {
    
    UIImageOrientation result = UIImageOrientationUp;
    CGImageSourceRef imageSource = CGImageSourceCreateWithData((__bridge CFDataRef)imageData, NULL);
    if (imageSource) {
        CFDictionaryRef properties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, NULL);
        if (properties) {
            CFTypeRef val;
            int exifOrientation;
            val = CFDictionaryGetValue(properties, kCGImagePropertyOrientation);
            if (val) {
                CFNumberGetValue(val, kCFNumberIntType, &exifOrientation);
                UIImageOrientation orientation = UIImageOrientationUp;
                
                switch (exifOrientation) {
                    case 1:
                        orientation = UIImageOrientationUp;
                        break;
                    case 3:
                        orientation = UIImageOrientationDown;
                        break;
                    case 8:
                        orientation = UIImageOrientationLeft;
                        break;
                    case 6:
                        orientation = UIImageOrientationRight;
                        break;
                        
                    case 2:
                        orientation = UIImageOrientationUpMirrored;
                        break;
                    case 4:
                        orientation = UIImageOrientationDownMirrored;
                        break;
                    case 5:
                        orientation = UIImageOrientationLeftMirrored;
                        break;
                    case 7:
                        orientation = UIImageOrientationRightMirrored;
                        break;
                    default:
                        break;
                }
                result = orientation;
            } // else - if it's not set it remains at up
            CFRelease((CFTypeRef) properties);
        } else {
            //NSLog(@"NO PROPERTIES, FAIL");
        }
        CFRelease(imageSource);
    }
    return result;
}


@end


