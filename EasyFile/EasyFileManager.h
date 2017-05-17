//
//  EasyFileManager.h
//  Images
//
//  Created by wangjufan on 14/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EasyFileManager : NSObject

-(BOOL) deleteCacheFile:(NSString *) shortPath;

-(BOOL) writeCache:(NSData *) data withFileName:(NSString *) shortPath;
-(BOOL) appendCache:(NSData *) data withFileName:(NSString *) shortPath;

-(NSData *) readCache:(NSString *) shortPath withLength:(NSInteger) length formPositon:(long long) position;
-(NSData *) readCache:(NSString *) shortPath;

+(BOOL) createCacheDirectory:(NSString *) root;


@end


