//
//  NSFileManager+Path.m
//  Images
//
//  Created by wangjufan on 14/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import "NSFileManager+Path.h"


@implementation NSFileManager(Path)


+(NSString *) rootTmpPath{
    return NSTemporaryDirectory();
}

+(NSString *) rootBundlePath{
    return [NSBundle mainBundle].resourcePath;
}

+(NSString *) rootDocPath{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
+(NSString *) rootLibPath{
    return  [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
}

+(NSString *) rootCachePath{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}
+(NSString *) rootPreferencesPath{
    return [NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES) lastObject];
}


@end



