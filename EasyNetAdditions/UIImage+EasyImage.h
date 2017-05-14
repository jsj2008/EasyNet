//
//  UIImage+EasyImage.h
//  Images
//
//  Created by wangjufan on 12/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(EasyImage)


+ (UIImage *) easyImageWithData:(NSData *)data;

+ (UIImage *) easyGifWithData:(NSData *)data;

@end
