//
//  EasyProgress.m
//  Images
//
//  Created by wangjufan on 13/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import "EasyProgress.h"

#import "UIImage+Header.h"

@implementation EasyProgress

-(void)headData:(NSData *) data withType:(NSString *) type {
    CGSize size = [UIImage imageSizeWithType:type andData:data];
    self.totalNumberOfBytes = size.height * size.width;
}

@end

