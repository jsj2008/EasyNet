//
//  ViewController.h
//  Images
//
//  Created by wangjufan on 12/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EasyImageOwnershipProtocol;

@interface ViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIImageView<EasyImageOwnershipProtocol> * imageView;

@end

