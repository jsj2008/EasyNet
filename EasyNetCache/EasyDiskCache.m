//
//  EasyDiskCache.m
//  Images
//
//  Created by wangjufan on 12/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import "EasyDiskCache.h"
#import <CommonCrypto/CommonCrypto.h>

#import "UIImage+EasyImage.h"

@interface EasyDiskCache(){
    NSString * _easyCacheRoot;
}

@end

@implementation EasyDiskCache

///////////////////////////////////////
- (NSString *)rootPath{
    if (_easyCacheRoot) {
        return _easyCacheRoot;
    }else{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        _easyCacheRoot = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"EasyDiskCache"];
        return _easyCacheRoot;
    }
}
- (NSString *)filePathForKey:(NSString *)key{
    NSData *data = [NSData dataWithBytes:[key UTF8String] length:key.length];
    if ([data length] == 0) {
        return nil;
    }
    unsigned char result[16];
    CC_MD5([data bytes], (CC_LONG)[data length], result);
    NSString *cacheKey = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                          result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
                          result[8], result[9], result[10], result[11],result[12], result[13], result[14], result[15]];
    NSString *prefix = [cacheKey substringToIndex:2];
    NSString *directoryPath = [self.rootPath stringByAppendingPathComponent:prefix];
    return [directoryPath stringByAppendingPathComponent:cacheKey];
}

////////////////
-(NSData *) dataForKey:(NSString *) key{
    NSString * filepath = [self filePathForKey:key];
    NSData *data = [NSData dataWithContentsOfFile:filepath];
    if (data) {
        return data;
    }
    
    // fallback because of https://github.com/rs/SDWebImage/pull/976 that added the extension to the disk file name
    // checking the key with and without the extension
    data = [NSData dataWithContentsOfFile:[filepath stringByDeletingPathExtension]];
    if (data) {
        return data;
    }
    
//    NSArray *customPaths = [self.customPaths copy];
//    for (NSString *path in customPaths) {
//        NSString *filePath = [self cachePathForKey:key inPath:path];
//        NSData *imageData = [NSData dataWithContentsOfFile:filePath];
//        if (imageData) {
//            return imageData;
//        }
//        
//        // fallback because of https://github.com/rs/SDWebImage/pull/976 that added the extension to the disk file name
//        // checking the key with and without the extension
//        imageData = [NSData dataWithContentsOfFile:[filePath stringByDeletingPathExtension]];
//        if (imageData) {
//            return imageData;
//        }
//    }
//    
    return nil;
}

-(UIImage *) imageForKey:(NSString *) key{
    NSData *data = [self dataForKey:key];
    if (data) {
        UIImage *image = [UIImage imageWithData:data];
//        image = [self scaledImageForKey:key image:image];
//        if (self.shouldDecompressImages) {
//            image = [UIImage decodedImageWithImage:image];
//        }
        return image;
    }
    return nil;
}

@end
