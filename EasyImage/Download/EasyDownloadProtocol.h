//
//  EasyDownloadProtocol.h
//  Images
//
//  Created by wangjufan on 12/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#ifndef EasyDownloadProtocol_h
#define EasyDownloadProtocol_h


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@class EasyImageParas;

@protocol EasyDownloadProtocol <NSObject>

- (void) easyDownload:(EasyImageParas *) paras;
-(void) easyCancelDownload:(EasyImageParas *) paras;

@end


#endif /* EasyDownloadProtocol_h */

