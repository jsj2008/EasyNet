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


+(instancetype) createProgress{
    return [EasyProgress new];
}

-(void)headData:(NSData *) data withType:(NSString *) type {
    CGSize size = [UIImage easyImageSizeForHeadData:data];
    self.totalNumberOfBytes = size.height * size.width * 16;
}

-(long long) totalNumberOfBytes{
    if (_totalNumberOfBytes == 0) {
        return 1000000;
    }
    return _totalNumberOfBytes;
}


@end


