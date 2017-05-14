//
//  UIImageView+EasyImage.h
//  Images
//
//  Created by wangjufan on 12/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol EasyImageProtocol;

@interface UIImageView(EasyImage)

-(void) easyImageWithPara:(id<EasyImageProtocol>) paras;
-(void) easyImageCancel;

- (void) easyGifInMainbundleForName:(NSString *) name;
- (void) easyPngInMainbundleForName:(NSString *) name;

@end


