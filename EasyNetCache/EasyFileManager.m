//
//  EasyFileManager.m
//  Images
//
//  Created by wangjufan on 14/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import "EasyFileManager.h"

#import "NSFileManager+Path.h"

#import <CommonCrypto/CommonCrypto.h>


@interface EasyFileManager()

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSFileHandle *> *fileHandles;

@end


@implementation EasyFileManager

-(instancetype) init{
    if (self = [super init]) {
        _fileHandles = [NSMutableDictionary new];
    }
    return self;
}


-(BOOL) writeCache:(NSData *) data withFileName:(NSString *) shortPath{
    /* 
     1 delete exist
     2 write
     3 close filehandle
     */
    NSString * cacheRoot = [NSFileManager rootCachePath];
    NSString * filePath = [cacheRoot stringByAppendingString:shortPath];
    
    NSFileHandle * handle = [self.fileHandles objectForKey:shortPath];
    if (handle) {
        return NO;
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
    handle = [NSFileHandle fileHandleForWritingAtPath:filePath];
    [handle writeData:data];
    [handle closeFile];
    return YES;
}

-(BOOL) deleteCacheFile:(NSString *) shortPath{
    NSString * cacheRoot = [NSFileManager rootCachePath];
    NSString * filePath = [cacheRoot stringByAppendingString:shortPath];
    
    NSFileHandle * handle = [self.fileHandles objectForKey:shortPath];
    if (handle) {
        [self.fileHandles removeObjectForKey:shortPath];
    }
    if ( [[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        return YES;
    }
    return NO;
}

-(BOOL) finishCacheFile:(NSString *) shortPath{
    NSFileHandle * handle = [self.fileHandles objectForKey:shortPath];
    if (handle) {
        [self.fileHandles removeObjectForKey:shortPath];
    }
    [handle closeFile];
    return YES;
}

-(BOOL) appendCache:(NSData *) data withFileName:(NSString *) shortPath{
    NSString * cacheRoot = [NSFileManager rootCachePath];
    NSString * filePath = [cacheRoot stringByAppendingString:shortPath];
    
    NSFileHandle * handle = [self.fileHandles objectForKey:shortPath];
    if ( [[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
    
    if (handle == nil) {
        handle = [NSFileHandle fileHandleForWritingAtPath:filePath];
        [self.fileHandles setObject:handle forKey:shortPath];
    }
    [handle seekToEndOfFile];
    [handle writeData:data];
    
    return YES;
}

-(NSData *) readCache:(NSString *) shortPath withLength:(NSInteger) length{
    NSString * cacheRoot = [NSFileManager rootCachePath];
    NSString * filePath = [cacheRoot stringByAppendingString:shortPath];
    
    return nil;
}


@end


