//
//  UIImageView+EasyImage.h
//  Images
//
//  Created by wangjufan on 12/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EasyImageParas.h"

@protocol EasyParaObjectProtocol;

@interface UIImageView(EasyImage)

-(void) easyImageWithPara:(id<EasyParaObjectProtocol>) paras;//you should call it in main thread
-(void) easyImageCancel;//you should call it in main thread

- (void) easyGifInMainbundleForName:(NSString *) name;
- (void) easyPngInMainbundleForName:(NSString *) name;

@end


