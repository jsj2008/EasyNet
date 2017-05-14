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

#import "EasyFileManager.h"

#define EasyDiskCache_Root @"EasyDiskCache_Root"

@interface EasyDiskCache()

@property (nonatomic, strong) EasyFileManager * easyFileManager;


@end

@implementation EasyDiskCache

-(instancetype) init{
    if (self = [super init]) {
        _easyFileManager = [EasyFileManager new];
    }
    return self;
}

-(void) startCache:(NSString *) url{
    NSString * shortPath = [self categorizingAndShorteningName:url];
    shortPath = [ EasyDiskCache_Root stringByAppendingString:shortPath];
    
    [self.easyFileManager deleteCacheFile:shortPath];
}

-(void) cache:(NSString *) url data:(NSData *) data{
    NSString * shortPath = [self categorizingAndShorteningName:url];
    shortPath = [ EasyDiskCache_Root stringByAppendingString:shortPath];
    
    [self.easyFileManager writeCache:data withFileName:shortPath];
}

-(void) finishCache:(NSString *) url{
    NSString * shortPath = [self categorizingAndShorteningName:url];
    shortPath = [ EasyDiskCache_Root stringByAppendingString:shortPath];
    [self.easyFileManager finishCacheFile:shortPath];
}

- (NSString *) categorizingAndShorteningName:(NSString *)key{
    NSString * shortPath = @"";
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
    shortPath = [shortPath stringByAppendingPathComponent:prefix];
    shortPath = [shortPath stringByAppendingPathComponent:cacheKey];
    return shortPath;
}


- (NSData *) dataForUrl:(NSString *)url {
//    NSString * filepath = [self filePathForKey:url];
//    NSData *data = [NSData dataWithContentsOfFile:filepath];
//    if (data) {
//        return data;
//    }
//    data = [NSData dataWithContentsOfFile:[filepath stringByDeletingPathExtension]];
//    if (data) {
//        return data;
//    }
    return nil;
}

-(UIImage *) imageForKey:(NSString *) key{
//    NSData *data = [self dataForKey:key];
//    if (data) {
//        UIImage *image = [UIImage imageWithData:data];
//        return image;
//    }
    return nil;
}


@end

