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

#import "EasyLog.h"
#import "EasyCachePolicy.h"


@interface EasyDiskCache()
@property (nonatomic, strong) EasyFileManager * easyFileManager;
@end


@implementation EasyDiskCache


+(void) load{
    [EasyFileManager createCacheDirectory:EasyUserCache_Path];
}

-(instancetype) init{
    if (self = [super init]) {
        _easyFileManager = [EasyFileManager new];
    }
    return self;
}

-(void) willStartAppendCache:(NSString *) url{
    NSString * shortPath = [self categorizingAndShorteningName:url];
    shortPath = [ EasyUserCache_Path stringByAppendingString:shortPath];
    [self.easyFileManager deleteCacheFile:shortPath];
}
-(void) appendCache:(NSString *) url data:(NSData *) data{
    NSString * shortPath = [self categorizingAndShorteningName:url];
    shortPath = [ EasyUserCache_Path stringByAppendingString:shortPath];
    [self.easyFileManager appendCache:data withFileName:shortPath];
}


-(void) deletableCache:(NSString *) url data:(NSData *) data{
    if (url == nil) {
        static NSString * sinfo = @"url is nil";
        EasyLog( sinfo );
        return;
    }
    NSString * shortPath = [self categorizingAndShorteningName:url];
    shortPath = [ EasyUserCache_Path stringByAppendingString:shortPath];
    [self.easyFileManager writeCache:data withFileName:shortPath];
}

- (NSString *) categorizingAndShorteningName:(NSString *)key{
    NSString * shortPath = @"/";
    NSData *data = [NSData dataWithBytes:[key UTF8String] length:key.length];
    if ([data length] == 0) {
        return nil;
    }
    unsigned char result[16];
    CC_MD5([data bytes], (CC_LONG)[data length], result);
    NSString *cacheKey = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                          result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
                          result[8], result[9], result[10], result[11],result[12], result[13], result[14], result[15]];
    shortPath = [shortPath stringByAppendingPathComponent:cacheKey];
//    shortPath = [shortPath stringByAppendingString:@""];
    return shortPath;
}


- (NSData *) dataForUrl:(NSString *)url {
    NSString * shortPath = [self categorizingAndShorteningName:url];
    shortPath = [ EasyUserCache_Path stringByAppendingString:shortPath];
    NSData *data = [self.easyFileManager readCache:shortPath];
    return data;
}


@end

