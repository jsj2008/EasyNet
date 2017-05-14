//
//  UIImage+Header.h
//  Images
//
//  Created by wangjufan on 13/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImage(Header)

+(CGSize) imageSizeWithType:(NSString *) type andData:(NSData *) data;


+(CGSize) imageSizeOfPNG:(NSData *) data ;
+(CGSize) imageSizeOfJPG:(NSData *) data ;


@end


