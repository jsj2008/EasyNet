//
//  NSFileManager+Path.h
//  Images
//
//  Created by wangjufan on 14/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSFileManager(Path)

+(NSString *) rootTmpPath;
+(NSString *) rootBundlePath;

+(NSString *) rootDocPath;
+(NSString *) rootLibPath;

+(NSString *) rootCachePath;
+(NSString *) rootPreferencesPath;


@end



