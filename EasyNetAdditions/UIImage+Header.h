//
//  UIImage+Header.h
//  Images
//
//  Created by wangjufan on 13/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImage(Header)

+ (NSString *) easyImageFormatForData:(NSData *)data;
+(UIImageOrientation)easyImageOrientationForData:(NSData *)imageData;

+(CGSize) easyImageSizeForHeadData:(NSData *) data;
+(CGSize) easyImageSizeOfPNG:(NSData *) data ;
+(CGSize) easyImageSizeOfJPG:(NSData *) data ;

@end


