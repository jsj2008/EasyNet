//
//  UIImageView+EasyImage.h
//  Images
//
//  Created by wangjufan on 12/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EasyImageParas.h"


@interface UIImageView(EasyImage)

-(void) easyImageWithPara:(EasyImageParas *) paras;//you should call it in main thread
-(void) easyImageCancel;//you should call it in main thread

- (void) easyGifInMainbundleForName:(NSString *) name;
- (void) easyPngInMainbundleForName:(NSString *) name;

@end


