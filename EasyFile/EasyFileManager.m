//
//  EasyFileManager.m
//  Images
//
//  Created by wangjufan on 14/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import "EasyFileManager.h"

#import "NSFileManager+EasyPath.h"

#import <CommonCrypto/CommonCrypto.h>

#import "EasyLog.h"

@interface EasyFileManager(){
    dispatch_semaphore_t _shortPathSemaphore;
}
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSObject *> * shortPathes;

@end


@implementation EasyFileManager


-(id) getSynObj:(NSString *) shortPath{
    dispatch_semaphore_wait(_shortPathSemaphore,DISPATCH_TIME_FOREVER);
    NSObject * sysObj = [_shortPathes objectForKey:shortPath];
    if (sysObj == nil) {
        [_shortPathes setObject:[NSObject  new] forKey: shortPath];
        sysObj = [_shortPathes objectForKey:shortPath];
    }
    dispatch_semaphore_signal(_shortPathSemaphore);
    return sysObj;
}

+(BOOL) createCacheDirectory:(NSString *) root{
    NSString * cacheRoot = [NSFileManager rootCachePath];
    root = [cacheRoot stringByAppendingString:root];
    static BOOL isDir = YES;
    if (![[NSFileManager defaultManager] fileExistsAtPath:root isDirectory:&isDir]) {
        BOOL status = [[NSFileManager defaultManager] createDirectoryAtPath:root withIntermediateDirectories:YES attributes:nil error:NULL];
        return status;
    }
    return YES;
}

-(instancetype) init{
    if (self = [super init]) {
        _shortPathes = [NSMutableDictionary new];
        _shortPathSemaphore = dispatch_semaphore_create(1);
    }
    return self;
}

-(BOOL) writeCache:(NSData *) data withFileName:(NSString *) shortPath{
    id sysObj = [self getSynObj:shortPath];
    @synchronized (sysObj) {
        [self deleteCacheFile:shortPath];
        NSFileHandle * handle = getFileHandler(shortPath, self);
        [handle writeData:data];
        [handle closeFile];
        return YES;
    }
}

-(BOOL) deleteCacheFile:(NSString *) shortPath{
    id sysObj = [self getSynObj:shortPath];
    @synchronized (sysObj) {
        NSString * filePath = getFilePath(shortPath);
        if ( [[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        }
        return YES;
    }
}

-(BOOL) appendCache:(NSData *) data withFileName:(NSString *) shortPath{
    id sysObj = [self getSynObj:shortPath];
    @synchronized (sysObj) {
        NSFileHandle * handle = getFileHandler(shortPath, self);
        [handle seekToEndOfFile];
        [handle writeData:data];
        [handle closeFile];
        return YES;
    }
}

/****************************************************************
 read
 
 ****************************************************************/

-(NSData *) readCache:(NSString *) shortPath withLength:(NSInteger) length formPositon:(long long) position{
    id sysObj = [self getSynObj:shortPath];
    @synchronized (sysObj) {
        NSFileHandle * handle = getFileReadHandler(shortPath, self);
        [handle seekToFileOffset:position];
        NSData * data = [handle readDataOfLength:length];
        [handle closeFile];
        return data;
    }
}

-(NSData *) readCache:(NSString *) shortPath{
    id sysObj = [self getSynObj:shortPath];
    @synchronized (sysObj) {
        NSFileHandle * handle = getFileReadHandler(shortPath, self);
        [handle seekToFileOffset:0];
        NSData * data = [handle readDataToEndOfFile];
        [handle closeFile];
        return data;
    }
}

/****************************************************************
  
 file path
 
 ****************************************************************/

static inline NSString * getFilePath(NSString *shortPath) {
    NSString * cacheRoot = [NSFileManager rootCachePath];
    NSString * filePath = [cacheRoot stringByAppendingString:shortPath];
    return filePath;
}

static NSFileHandle * getFileHandler(NSString * shortPath, EasyFileManager * fileManager){
    id sysObj = [fileManager getSynObj:shortPath];
    @synchronized (sysObj) {
        NSString * filePath = getFilePath(shortPath);
        NSLog(@"%@", filePath);
        NSLog(@"%@", shortPath);
        BOOL result = YES;
        if (![[NSFileManager defaultManager] fileExistsAtPath: filePath]) {
            result = [[NSFileManager defaultManager] createFileAtPath: filePath contents:[NSData data] attributes:nil];
        }
        if (result) {
            NSFileHandle * handle = [NSFileHandle fileHandleForWritingAtPath:filePath];
            return handle;
        }
        return nil;
    }
}

static NSFileHandle * getFileReadHandler(NSString * shortPath, EasyFileManager * fileManager){
    id sysObj = [fileManager getSynObj:shortPath];
    @synchronized (sysObj) {
        NSString * filePath = getFilePath(shortPath);
        EasyLog(filePath);
        EasyLog(shortPath);
        if (![[NSFileManager defaultManager] fileExistsAtPath: filePath]) {
            return nil;
        }
        NSFileHandle * handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
        return handle;
    }
}


@end


