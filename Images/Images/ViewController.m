//
//  ViewController.m
//  Images
//
//  Created by wangjufan on 12/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import "ViewController.h"

#import "EasyImage.h"

#import "NSObject+Dispatch.h"

@interface ViewController (){
    NSMutableArray * urls;
    NSMutableArray * paras;
    
    NSMutableArray * imageviewS;
    
    EasyCacheManager * manager;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    paras = [[NSMutableArray alloc] init];
    imageviewS = [[NSMutableArray alloc] init];
    
    urls = [[NSMutableArray alloc] init];
    
    manager = [EasyCacheManager new];
//    [urls addObject:@"http://img.ipc.me/uploads/post/17031/thumb/140x100.jpg"];
//    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/02,c_fill,d_picasa,h_128,w_260.jpg"];
//    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/05,c_fill,d_picasa,h_128,w_160.jpg"];
//    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/05,c_fill,d_picasa,h_128,w_160.jpg"];
//    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/05,c_fill,d_picasa,h_128,w_160.jpg"];
//    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/01,c_fill,d_flickr,h_270,w_360.jpg"];
//    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/02,c_fill,d_picasa,h_128,w_260.jpg"];
//    [urls addObject:@"http://img.ipc.me/uploads/post/17031/thumb/140x100.jpg"];
//    [urls addObject:@"http://img.ipc.me/uploads/post/17031/thumb/140x100.jpg"];
//    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/01,c_fill,d_flickr,h_270,w_360.jpg"];
//    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/02,c_fill,d_picasa,h_128,w_260.jpg"];
//    [urls addObject:@"http://img.ipc.me/uploads/post/17031/thumb/140x100.jpg"];
//    [urls addObject:@"http://img.ipc.me/uploads/post/17031/thumb/140x100.jpg"];
//    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/01,c_fill,d_flickr,h_270,w_360.jpg"];
//    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/02,c_fill,d_picasa,h_128,w_260.jpg"];
//    [urls addObject:@"http://img.ipc.me/uploads/post/17031/thumb/140x100.jpg"];
//    [urls addObject:@"http://img.ipc.me/uploads/post/17031/thumb/140x100.jpg"];
//    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/01,c_fill,d_flickr,h_270,w_360.jpg"];
//    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/02,c_fill,d_picasa,h_128,w_260.jpg"];
//    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/01,c_fill,d_flickr,h_270,w_360.jpg"];
//    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/01,c_fill,d_flickr,h_270,w_360.jpg"];
//    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/02,c_fill,d_picasa,h_128,w_260.jpg"];
//    [urls addObject:@"http://img.ipc.me/uploads/post/17031/thumb/140x100.jpg"];
//    [urls addObject:@"http://img.ipc.me/uploads/post/17031/thumb/140x100.jpg"];
//    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/01,c_fill,d_flickr,h_270,w_360.jpg"];
//    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/02,c_fill,d_picasa,h_128,w_260.jpg"];
//    [urls addObject:@"http://img.ipc.me/uploads/post/17031/thumb/140x100.jpg"];
//    [urls addObject:@"http://c.3g.163.com/photo/api/list/0096/4GJ60096.json"];
    [urls addObject:@"http://sony.it168.com/data/attachment/forum/201410/20/2154195j037033ujs7cio0.jpg"];
    
    for (NSString *sdf in urls) {
        [imageviewS addObject:[UIImageView new]];
    }

    __weak typeof(self) wself = self;
    
    __block int i = 0;
    [self easyDispatchOnCon:^{
        for (NSString * key in urls) {
            
            id<EasyImageProtocol> para = [manager createEasyImageParas];
            para.url = key;
            para.cacher = [manager getEasyDiskCache];
            para.autoCancel = YES;
            para.recycleBlock = ^(id<EasyImageProtocol> para){
                [manager collectEasyImageParas:para];
            };
            
//            para.progressBlock = ^(float ratio){
//                NSLog(@"==========%.2f=============", ratio);
//            };
            
//            para.downloader = [manager getTinyFileDownloader];
//            para.owner = [imageviewS objectAtIndex:i];
//            [[imageviewS objectAtIndex:i] easyImageWithPara:para];
            
            para.downloader = [manager getBigFileDownloader];
            para.owner = wself.imageView;
            [wself.imageView easyImageWithPara:para];
            
            i++;
        }
    }];
    
    
    [self.imageView easyGifInMainbundleForName:@"stream_loading"];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
