//
//  ViewController.m
//  Images
//
//  Created by wangjufan on 12/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import "ViewController.h"

#import "EasyImage.h"



@interface ViewController (){
    NSMutableArray * urls;
    NSMutableArray * paras;
    
    EasyCacheManager * manager;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    paras = [[NSMutableArray alloc] init];
    urls = [[NSMutableArray alloc] init];
    
    manager = [EasyCacheManager new];
    [urls addObject:@"http://img.ipc.me/uploads/post/17031/thumb/140x100.jpg"];
    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/02,c_fill,d_picasa,h_128,w_260.jpg"];
    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/05,c_fill,d_picasa,h_128,w_160.jpg"];
    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/05,c_fill,d_picasa,h_128,w_160.jpg"];
    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/05,c_fill,d_picasa,h_128,w_160.jpg"];
    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/01,c_fill,d_flickr,h_270,w_360.jpg"];
    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/02,c_fill,d_picasa,h_128,w_260.jpg"];
    [urls addObject:@"http://img.ipc.me/uploads/post/17031/thumb/140x100.jpg"];
    [urls addObject:@"http://img.ipc.me/uploads/post/17031/thumb/140x100.jpg"];
    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/01,c_fill,d_flickr,h_270,w_360.jpg"];
    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/02,c_fill,d_picasa,h_128,w_260.jpg"];
    [urls addObject:@"http://img.ipc.me/uploads/post/17031/thumb/140x100.jpg"];
    [urls addObject:@"http://img.ipc.me/uploads/post/17031/thumb/140x100.jpg"];
    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/01,c_fill,d_flickr,h_270,w_360.jpg"];
    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/02,c_fill,d_picasa,h_128,w_260.jpg"];
    [urls addObject:@"http://img.ipc.me/uploads/post/17031/thumb/140x100.jpg"];
    [urls addObject:@"http://img.ipc.me/uploads/post/17031/thumb/140x100.jpg"];
    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/01,c_fill,d_flickr,h_270,w_360.jpg"];
    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/02,c_fill,d_picasa,h_128,w_260.jpg"];
    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/01,c_fill,d_flickr,h_270,w_360.jpg"];
    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/02,c_fill,d_picasa,h_128,w_260.jpg"];
    [urls addObject:@"http://img.ipc.me/uploads/post/17031/thumb/140x100.jpg"];
    [urls addObject:@"http://img.ipc.me/uploads/post/17031/thumb/140x100.jpg"];
    [urls addObject:@"http://img.ipc.me/uploads/post/17031/thumb/140x100.jpg"];
    [urls addObject:@"http://img.ipc.me/uploads/post/17031/thumb/140x100.jpg"];
    [urls addObject:@"http://img.ipc.me/uploads/post/17031/thumb/140x100.jpg"];
    [urls addObject:@"http://img.ipc.me/uploads/post/17031/thumb/140x100.jpg"];
    [urls addObject:@"http://img.ipc.me/uploads/post/17031/thumb/140x100.jpg"];
    [urls addObject:@"http://img.ipc.me/uploads/post/17031/thumb/140x100.jpg"];
    [urls addObject:@"http://img.ipc.me/uploads/post/17031/thumb/140x100.jpg"];
    [urls addObject:@"http://img.ipc.me/uploads/post/17031/thumb/140x100.jpg"];
    [urls addObject:@"http://img.ipc.me/uploads/post/17031/thumb/140x100.jpg"];
    [urls addObject:@"http://img.ipc.me/uploads/post/17031/thumb/140x100.jpg"];
    [urls addObject:@"http://img.ipc.me/uploads/post/17031/thumb/140x100.jpg"];
    [urls addObject:@"http://img.ipc.me/uploads/post/17031/thumb/140x100.jpg"];
    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/01,c_fill,d_flickr,h_270,w_360.jpg"];
    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/02,c_fill,d_picasa,h_128,w_260.jpg"];
    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/01,c_fill,d_flickr,h_270,w_360.jpg"];
    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/02,c_fill,d_picasa,h_128,w_260.jpg"];
    [urls addObject:@"http://img.ipc.me/uploads/post/17031/thumb/140x100.jpg"];
    [urls addObject:@"http://img.ipc.me/uploads/post/17031/thumb/140x100.jpg"];
    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/01,c_fill,d_flickr,h_270,w_360.jpg"];
    [urls addObject:@"http://evathumber.avnpc.com/thumb/d/02,c_fill,d_picasa,h_128,w_260.jpg"];
    [urls addObject:@"http://img.ipc.me/uploads/post/17031/thumb/140x100.jpg"];

    __weak typeof(self) wself = self;
    
    for (NSString * key in urls) {
        
        id<EasyParaObjectProtocol> para = [manager createEasyImageParas];
        para.url = key;
        para.cacher = [manager getEasyDiskCache];
        para.downloader = [manager getTinyFileDownloader];
        para.imageView = wself.imageView;
        para.autoCancel = YES;
        
        para.recycleBlock = ^(EasyImageParas * par){
            [manager collectEasyImageParas:par];
        };
        
//        [paras addObject:para];
        [self.imageView easyImageWithPara:para];
    }
    
//    [self.imageView easyGifInMainbundleForName:@"stream_loading"];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
