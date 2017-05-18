//
//  EasyCachePolicy.m
//  Images
//
//  Created by wangjufan on 18/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import "EasyCachePolicy.h"

#import <UIKit/UIKit.h>

#import "EasyCachePolicyProtocol.h"

@implementation EasyCachePolicy

@synthesize memoryCacheMode = _memoryCacheMode;
@synthesize diskCacheMode = _diskCacheMode;


-(void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(instancetype) init{
    if (self = [super init]) {
        
        _memoryCacheMode = YES;
        _diskCacheMode = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMemoryWarning:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate:)  name:UIApplicationWillTerminateNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    }
    return self;
}

-(void) didReceiveMemoryWarning:(NSNotification *) notification{
    
}

-(void) applicationWillTerminate:(NSNotification *) notification{
    
}

-(void) applicationDidEnterBackground:(NSNotification *) notification{
    
}


@end

