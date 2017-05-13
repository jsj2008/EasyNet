//
//  UIImage+Header.m
//  Images
//
//  Created by wangjufan on 13/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import "UIImage+Header.h"


@implementation UIImage(Header)


+(CGSize) imageSizeOfPNG:(NSData *) data {
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
+(CGSize) imageSizeOfJPG:(NSData *) data {
    
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

+(CGSize) imageSizeWithType:(NSString *) type andData:(NSData *) data{
    if ([[type lowercaseString] containsString:@".png"]) {
        return [self imageSizeOfPNG:data];
    }
    if ([[type lowercaseString] containsString:@".jpg"]) {
        return [self imageSizeOfJPG:data];
    }
    return CGSizeZero;
}

@end


