//
//  EasyProgress.h
//  Images
//
//  Created by wangjufan on 13/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EasyProgress : NSObject

@property (nonatomic, assign) long long totalNumberOfBytes;
@property (nonatomic, assign) long long currentNumberOfBytes;
@property (nonatomic, assign) float ratio;

-(void)headData:(NSData *) data withType:(NSString *) type;


@end
