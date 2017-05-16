//
//  EasyConBigFileDownload.m
//  Images
//
//  Created by wangjufan on 14/5/2017.
//  Copyright © 2017 DuduWang. All rights reserved.
//

#import "EasyConBigFileDownload.h"


#import "EasyLog.h"

#import "NSObject+Dispatch.h"
#import "EasyQueueProtocol.h"
#import "EasyInnerImageProtocol.h"

#import "EasyProgress.h"

#import "EasyDiskCache.h"
#import "EasyCacheProtocol.h"

@interface EasyConBigFileDownload() <NSURLSessionDelegate,
NSURLSessionTaskDelegate,
NSURLSessionDataDelegate,
NSURLSessionDownloadDelegate>{
    
    
}

@property (nonatomic, strong) NSMutableDictionary<NSString *, EasyProgress*> * progresses;


@property (nonatomic, strong) id<EasyCacheProtocol> diskCacher;

@property (nonatomic, strong) NSURLSession * urlSession;

@end


@implementation EasyConBigFileDownload

@synthesize queueManager = _queueManager;

-(instancetype) init{
    if (self = [super init]) {
        _progresses = [NSMutableDictionary new];
    }
    return self;
}

-(NSURLSession *) urlSession{
    if (_urlSession == nil) {
        @synchronized (self) {
            if (!_urlSession) {
                NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
                configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
                _urlSession = [NSURLSession sessionWithConfiguration:configuration
                                                            delegate:self
                                                       delegateQueue:nil];
            }
        }
    }
    return _urlSession;
}

-(id<EasyCacheProtocol>) diskCacher{
    if (_diskCacher == nil) {
        _diskCacher = [EasyDiskCache new];
    }
    return _diskCacher;
}

-(void) removeProgresses:(id<EasyImageProtocol>) para{
    __weak typeof(self) wself = self;
    dispatch_queue_t queue = [_queueManager queueForKey:EasyFileDownload_ConQueue];
    dispatch_barrier_async(queue, ^{
        [wself.progresses setObject:para forKey:para.url];
    });
}
-(void) addProgresses:(id<EasyImageProtocol>) para {
    __weak typeof(self) wself = self;
    dispatch_queue_t queue = [_queueManager queueForKey:EasyFileDownload_ConQueue];
    EasyProgress * progress = [EasyProgress createProgress];
    progress.easyImagePara = (id<EasyInnerImageProtocol>) para;
    dispatch_barrier_async(queue, ^{
        [wself.progresses setObject:progress forKey:para.url];
    });
}
-(EasyProgress *) readProgres:(NSString *) key{
    __weak typeof(self) wself = self;
    dispatch_queue_t queue = [_queueManager queueForKey:EasyFileDownload_ConQueue];
    __block EasyProgress * progress = nil;
    dispatch_barrier_sync(queue, ^{
        progress = [wself.progresses objectForKey:key];
    });
    return progress;
}

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

- (void) easyDownload:(id<EasyImageProtocol>) para {
    __weak typeof(self) wself = self;
    id<EasyInnerImageProtocol> paras = (id<EasyInnerImageProtocol>) para;
    
    dispatch_block_t downloadBlock = ^{
        if (paras.hasCanceled) {
            [wself removeProgresses:para];
            return ;
        }
        EasyLog(@"begin downloading  !!!");
        [wself addProgresses:para];
        [wself.diskCacher willStartAppendCache:para.url];
        
        NSURL * url = [NSURL URLWithString:paras.url];
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
        [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
        
        NSURLSessionDataTask * dataTask = [wself.urlSession dataTaskWithRequest:request];
        [dataTask resume];
    };
    
    [_queueManager dispatchBlock:downloadBlock onQueue:EasyFileDownload_ConQueue];
}
-(void) easyCancelDownload:(id<EasyImageProtocol>) para{
    id<EasyInnerImageProtocol> paras = (id<EasyInnerImageProtocol>) para;
    [self removeProgresses:para];
    if (paras.failedBlock) {
        paras.failedBlock(paras,nil);
    }
}

-(void) loadingFinishedWithEerror:(NSError *) error
                      forDataTask:(NSURLSessionDataTask *) dataTask{
    
    EasyProgress * progress = [self readProgres: [dataTask.response.URL absoluteString]];
    id<EasyInnerImageProtocol> para = progress.easyImagePara;

    if (error == nil) {
        if (para.successBlock) {
            para.successBlock(para);
        }
        NSData * data = [self.diskCacher dataForUrl:para.url];
        UIImage * image = [UIImage imageWithData:data];
        UIImageView * owner = para.owner;
        [data easyDispatchOnMain:^{
            owner.image = image;
        }];
        
    } else {
        if (para.failedBlock) {
            para.failedBlock(para,error);
        }
    }
}

-(void) didReceiveData:(NSData *) data forTask:(NSURLSessionDataTask *) dataTask {
    
    EasyProgress * progress = [self readProgres: [dataTask.response.URL absoluteString]];
    id<EasyInnerImageProtocol> para = progress.easyImagePara;
    [self.diskCacher appendCache:para.url data:data];

    if (para.progressBlock) {
        para.progressBlock(2);
    }
}

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/*********************************************************
 NSURLSessionDelegate
 *********************************************************/

/* The last message a session receives.  A session will only become
 * invalid because of a systemic error or when it has been
 * explicitly invalidated, in which case the error parameter will be nil.
 */
- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error{
    
}

/* If implemented, when a connection level authentication challenge
 * has occurred, this delegate will be given the opportunity to
 * provide authentication credentials to the underlying
 * connection. Some types of authentication will apply to more than
 * one request on a given connection to a server (SSL Server Trust
 * challenges).  If this delegate message is not implemented, the
 * behavior will be to use the default handling, which may involve user
 * interaction.
 */
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    
}

/* If an application has received an
 * -application:handleEventsForBackgroundURLSession:completionHandler:
 * message, the session delegate will receive this message to indicate
 * that all messages previously enqueued for this session have been
 * delivered.  At this time it is safe to invoke the previously stored
 * completion handler, or to begin any internal updates that will
 * result in invoking the completion handler.
 */
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session NS_AVAILABLE_IOS(7_0){
    
}

/*********************************************************
 NSURLSessionTaskDelegate
 *********************************************************/

/*
 * Messages related to the operation of a specific task.
 */

/* An HTTP request is attempting to perform a redirection to a different
 * URL. You must invoke the completion routine to allow the
 * redirection, allow the redirection with a modified request, or
 * pass nil to the completionHandler to cause the body of the redirection
 * response to be delivered as the payload of this request. The default
 * is to follow redirections.
 *
 * For tasks in background sessions, redirections will always be followed and this method will not be called.
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
willPerformHTTPRedirection:(NSHTTPURLResponse *)response
        newRequest:(NSURLRequest *)request
 completionHandler:(void (^)(NSURLRequest * _Nullable))completionHandler{
    
}

/* The task has received a request specific authentication challenge.
 * If this delegate is not implemented, the session specific authentication challenge
 * will *NOT* be called and the behavior will be the same as using the default handling
 * disposition.
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    
}

/* Sent if a task requires a new, unopened body stream.  This may be
 * necessary when authentication has failed for any request that
 * involves a body stream.
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
 needNewBodyStream:(void (^)(NSInputStream * _Nullable bodyStream))completionHandler{
    
}

/*
 * Sent when complete statistics information has been collected for the task.
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didFinishCollectingMetrics:(NSURLSessionTaskMetrics *)metrics API_AVAILABLE(macosx(10.12), ios(10.0), watchos(3.0), tvos(10.0)){
    
}

/* Sent as the last message related to a specific task.  Error may be
 * nil, which implies that no error occurred and this task is complete.
 */

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error{
    [self loadingFinishedWithEerror:error forDataTask:task];
}


/*********************************************************
 NSURLSessionDataDelegate
 *********************************************************/
/*
 * Messages related to the operation of a task that delivers data
 * directly to the delegate.
 */

/* The task has received a response and no further messages will be
 * received until the completion block is called. The disposition
 * allows you to cancel a request or to turn a data task into a
 * download task. This delegate message is optional - if you do not
 * implement it, you can get the response as a property of the task.
 *
 * This method will not be called for background upload tasks (which cannot be converted to download tasks).
 */

/* mutex with didReceiveData
 - (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
 didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler{
 EasyLog(response);
 }
 */


/* Notification that a data task has become a download task.  No
 * future messages will be sent to the data task.
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didBecomeDownloadTask:(NSURLSessionDownloadTask *)downloadTask{
    
}

/*
 * Notification that a data task has become a bidirectional stream
 * task.  No future messages will be sent to the data task.  The newly
 * created streamTask will carry the original request and response as
 * properties.
 *
 * For requests that were pipelined, the stream object will only allow
 * reading, and the object will immediately issue a
 * -URLSession:writeClosedForStream:.  Pipelining can be disabled for
 * all requests in a session, or by the NSURLRequest
 * HTTPShouldUsePipelining property.
 *
 * The underlying connection is no longer considered part of the HTTP
 * connection cache and won't count against the total number of
 * connections per host.
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didBecomeStreamTask:(NSURLSessionStreamTask *)streamTask{
    
}

/* Sent when data is available for the delegate to consume.  It is
 * assumed that the delegate will retain and not copy the data.  As
 * the data may be discontiguous, you should use
 * [NSData enumerateByteRangesUsingBlock:] to access it.
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data{
    
    [self didReceiveData:(NSData *)data forTask:dataTask];
    
}

/* Invoke the completion routine with a valid NSCachedURLResponse to
 * allow the resulting data to be cached, or pass nil to prevent
 * caching. Note that there is no guarantee that caching will be
 * attempted for a given resource, and you should not rely on this
 * message to receive the resource data.
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
 willCacheResponse:(NSCachedURLResponse *)proposedResponse
 completionHandler:(void (^)(NSCachedURLResponse * _Nullable cachedResponse))completionHandler{
    [self loadingFinishedWithEerror:nil forDataTask:dataTask];
}


/*********************************************************
 NSURLSessionDownloadDelegate
 *********************************************************/

/*
 * Messages related to the operation of a task that writes data to a
 * file and notifies the delegate upon completion.
 */

/* Sent when a download task that has completed a download.  The delegate should
 * copy or move the file at the given location to a new location as it will be
 * removed when the delegate message returns. URLSession:task:didCompleteWithError: will
 * still be called.
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
    EasyLog(@"--------------------");
}


/* Sent periodically to notify the delegate of download progress. */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    EasyLog("--------------------");
}

/* Sent when a download has been resumed. If a download failed with an
 * error, the -userInfo dictionary of the error will contain an
 * NSURLSessionDownloadTaskResumeData key, whose value is the resume
 * data.
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes{
    EasyLog("--------------------");
}


@end


