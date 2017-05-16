//
//  NSFileManager+EasyPath.h
//  Images
//
//  Created by wangjufan on 16/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSFileManager(EasyPath)

+(NSString *) rootTmpPath;
+(NSString *) rootBundlePath;

+(NSString *) rootDocPath;
+(NSString *) rootLibPath;

+(NSString *) rootCachePath;
+(NSString *) rootPreferencesPath;

@end


