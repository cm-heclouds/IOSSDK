// ONAFURLConnectionOperation.m
//
// Copyright (c) 2011 Gowalla (http://gowalla.com/)
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "ONAFURLConnectionOperation.h"

#if TARGET_OS_WATCH
#import <objc/runtime.h>
#endif

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)
    #import <UIKit/UIKit.h>
#endif

#if !__has_feature(objc_arc)
#error ONAFNetworking must be built with ARC.
// You can turn on ARC for only ONAFNetworking files by adding -fobjc-arc to the build phase for each of its files.
#endif

typedef enum {
    ONAFOperationPausedState      = -1,
    ONAFOperationReadyState       = 1,
    ONAFOperationExecutingState   = 2,
    ONAFOperationFinishedState    = 3,
} _ONAFOperationState;

typedef signed short ONAFOperationState;

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && !TARGET_OS_WATCH
typedef UIBackgroundTaskIdentifier ONAFBackgroundTaskIdentifier;
#endif

static NSString * const kONAFNetworkingLockName = @"cn.leancloud.networking.operation.lock";

NSString * const ONAFNetworkingErrorDomain = @"ONAFNetworkingErrorDomain";
NSString * const ONAFNetworkingOperationFailingURLRequestErrorKey = @"ONAFNetworkingOperationFailingURLRequestErrorKey";
NSString * const ONAFNetworkingOperationFailingURLResponseErrorKey = @"ONAFNetworkingOperationFailingURLResponseErrorKey";

NSString * const ONAFNetworkingOperationDidStartNotification = @"cn.leancloud.networking.operation.start";
NSString * const ONAFNetworkingOperationDidFinishNotification = @"cn.leancloud.networking.operation.finish";

typedef void (^ONAFURLConnectionOperationProgressBlock)(ONAFURLConnectionOperation *operation, NSUInteger bytes, long long totalBytes, long long totalBytesExpected);
typedef BOOL (^ONAFURLConnectionOperationAuthenticationAgainstProtectionSpaceBlock)(NSURLConnection *connection, NSURLProtectionSpace *protectionSpace);
typedef void (^ONAFURLConnectionOperationAuthenticationChallengeBlock)(NSURLConnection *connection, NSURLAuthenticationChallenge *challenge);
typedef NSCachedURLResponse * (^ONAFURLConnectionOperationCacheResponseBlock)(NSURLConnection *connection, NSCachedURLResponse *cachedResponse);
typedef NSURLRequest * (^ONAFURLConnectionOperationRedirectResponseBlock)(NSURLConnection *connection, NSURLRequest *request, NSURLResponse *redirectResponse);

static inline NSString * ONAFKeyPathFromOperationState(ONAFOperationState state) {
    switch (state) {
        case ONAFOperationReadyState:
            return @"isReady";
        case ONAFOperationExecutingState:
            return @"isExecuting";
        case ONAFOperationFinishedState:
            return @"isFinished";
        case ONAFOperationPausedState:
            return @"isPaused";
        default:
            return @"state";
    }
}

static inline BOOL ONAFStateTransitionIsValid(ONAFOperationState fromState, ONAFOperationState toState, BOOL isCancelled) {
    switch (fromState) {
        case ONAFOperationReadyState:
            switch (toState) {
                case ONAFOperationPausedState:
                case ONAFOperationExecutingState:
                    return YES;
                case ONAFOperationFinishedState:
                    return isCancelled;
                default:
                    return NO;
            }
        case ONAFOperationExecutingState:
            switch (toState) {
                case ONAFOperationPausedState:
                case ONAFOperationFinishedState:
                    return YES;
                default:
                    return NO;
            }
        case ONAFOperationFinishedState:
            return NO;
        case ONAFOperationPausedState:
            return toState == ONAFOperationReadyState;
        default:
            return YES;
    }
}

@interface ONAFURLConnectionOperation ()
@property (readwrite, nonatomic, assign) ONAFOperationState state;
@property (readwrite, nonatomic, assign, getter = isCancelled) BOOL cancelled;
@property (readwrite, nonatomic, strong) NSRecursiveLock *lock;
@property (readwrite, nonatomic, strong) NSURLConnection *connection;
@property (readwrite, nonatomic, strong) NSURLRequest *request;
@property (readwrite, nonatomic, strong) NSURLResponse *response;
@property (readwrite, nonatomic, strong) NSError *error;
@property (readwrite, nonatomic, strong) NSData *responseData;
@property (readwrite, nonatomic, copy) NSString *responseString;
@property (readwrite, nonatomic, assign) NSStringEncoding responseStringEncoding;
@property (readwrite, nonatomic, assign) long long totalBytesRead;
#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && !TARGET_OS_WATCH
@property (readwrite, nonatomic, assign) ONAFBackgroundTaskIdentifier backgroundTaskIdentifier;
#endif
@property (readwrite, nonatomic, copy) ONAFURLConnectionOperationProgressBlock uploadProgress;
@property (readwrite, nonatomic, copy) ONAFURLConnectionOperationProgressBlock downloadProgress;
@property (readwrite, nonatomic, copy) ONAFURLConnectionOperationAuthenticationAgainstProtectionSpaceBlock authenticationAgainstProtectionSpace;
@property (readwrite, nonatomic, copy) ONAFURLConnectionOperationAuthenticationChallengeBlock authenticationChallenge;
@property (readwrite, nonatomic, copy) ONAFURLConnectionOperationCacheResponseBlock cacheResponse;
@property (readwrite, nonatomic, copy) ONAFURLConnectionOperationRedirectResponseBlock redirectResponse;

- (void)operationDidStart;
- (void)finish;
- (void)cancelConnection;
@end

@implementation ONAFURLConnectionOperation
@synthesize state = _state;
@synthesize cancelled = _cancelled;
@synthesize connection = _connection;
@synthesize runLoopModes = _runLoopModes;
@synthesize request = _request;
@synthesize response = _response;
@synthesize error = _error;
@synthesize responseData = _responseData;
@synthesize responseString = _responseString;
@synthesize responseStringEncoding = _responseStringEncoding;
@synthesize totalBytesRead = _totalBytesRead;
@dynamic inputStream;
@synthesize outputStream = _outputStream;
@synthesize userInfo = _userInfo;
#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && !TARGET_OS_WATCH
@synthesize backgroundTaskIdentifier = _backgroundTaskIdentifier;
#endif
@synthesize uploadProgress = _uploadProgress;
@synthesize downloadProgress = _downloadProgress;
@synthesize authenticationAgainstProtectionSpace = _authenticationAgainstProtectionSpace;
@synthesize authenticationChallenge = _authenticationChallenge;
@synthesize cacheResponse = _cacheResponse;
@synthesize redirectResponse = _redirectResponse;
@synthesize lock = _lock;

+ (void) __attribute__((noreturn)) networkRequestThreadEntryPoint:(id)__unused object {
    do {
        @autoreleasepool {
            [[NSRunLoop currentRunLoop] run];
        }
    } while (YES);
}

+ (NSThread *)networkRequestThread {
    static NSThread *_networkRequestThread = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _networkRequestThread = [[NSThread alloc] initWithTarget:self selector:@selector(networkRequestThreadEntryPoint:) object:nil];
        [_networkRequestThread start];
    });
    
    return _networkRequestThread;
}

+ (NSArray *)pinnedCertificates {
    static NSArray *_pinnedCertificates = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSArray *paths = [bundle pathsForResourcesOfType:@"cer" inDirectory:@"."];
        NSMutableArray *certificates = [NSMutableArray array];
        for (NSString *path in paths) {
            NSData *certificateData = [NSData dataWithContentsOfFile:path];
            [certificates addObject:certificateData];
        }
        _pinnedCertificates = [[NSArray alloc] initWithArray:certificates];
    });
    
    return _pinnedCertificates;
}

- (id)initWithRequest:(NSURLRequest *)urlRequest {
    self = [super init];
    if (!self) {
		return nil;
    }
    
    self.lock = [[NSRecursiveLock alloc] init];
    self.lock.name = kONAFNetworkingLockName;
    
    self.runLoopModes = [NSSet setWithObject:NSRunLoopCommonModes];
    
    self.request = urlRequest;
    
    self.outputStream = [NSOutputStream outputStreamToMemory];

    self.state = ONAFOperationReadyState;
	
    return self;
}

- (void)dealloc {
    if (_outputStream) {
        [_outputStream close];
        _outputStream = nil;
    }

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && !TARGET_OS_WATCH
    if (_backgroundTaskIdentifier) {
        [[UIApplication sharedApplication] endBackgroundTask:_backgroundTaskIdentifier];
        _backgroundTaskIdentifier = UIBackgroundTaskInvalid;
    }
#endif
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, state: %@, cancelled: %@ request: %@, response: %@>", NSStringFromClass([self class]), self, ONAFKeyPathFromOperationState(self.state), ([self isCancelled] ? @"YES" : @"NO"), self.request, self.response];
}

- (void)setCompletionBlock:(void (^)(void))block {
    [self.lock lock];
    if (!block) {
        [super setCompletionBlock:nil];
    } else {
        __weak __typeof(&*self)weakSelf = self;
        [super setCompletionBlock:^ {
            __strong __typeof(&*weakSelf)strongSelf = weakSelf;
			
            block();
            [strongSelf setCompletionBlock:nil];
        }];
    }
    [self.lock unlock];
}

- (NSInputStream *)inputStream {
    return self.request.HTTPBodyStream;
}

- (void)setInputStream:(NSInputStream *)inputStream {
    [self willChangeValueForKey:@"inputStream"];
    NSMutableURLRequest *mutableRequest = [self.request mutableCopy];
    mutableRequest.HTTPBodyStream = inputStream;
    self.request = mutableRequest;
    [self didChangeValueForKey:@"inputStream"];
}

- (void)setOutputStream:(NSOutputStream *)outputStream {
    if (outputStream == _outputStream) {
        return;
    }
    
    [self willChangeValueForKey:@"outputStream"];
    if (_outputStream) {
        [_outputStream close];
    }
    _outputStream = outputStream;
    [self didChangeValueForKey:@"outputStream"];
}

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && !TARGET_OS_WATCH
- (void)setShouldExecuteAsBackgroundTaskWithExpirationHandler:(void (^)(void))handler {
    [self.lock lock];
    if (!self.backgroundTaskIdentifier) {    
        UIApplication *application = [UIApplication sharedApplication];
        __weak __typeof(&*self)weakSelf = self;
        self.backgroundTaskIdentifier = [application beginBackgroundTaskWithExpirationHandler:^{
            __strong __typeof(&*weakSelf)strongSelf = weakSelf;
            
            if (handler) {
                handler();
            }
            
            if (strongSelf) {
                [strongSelf cancel];
                
                [application endBackgroundTask:strongSelf.backgroundTaskIdentifier];
                strongSelf.backgroundTaskIdentifier = UIBackgroundTaskInvalid;
            }
        }];
    }
    [self.lock unlock];
}
#endif

- (void)setUploadProgressBlock:(void (^)(ONAFURLConnectionOperation *operation, NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))block {
    self.uploadProgress = block;
}

- (void)setDownloadProgressBlock:(void (^)(ONAFURLConnectionOperation *operation, NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead))block {
    self.downloadProgress = block;
}

- (void)setAuthenticationAgainstProtectionSpaceBlock:(BOOL (^)(NSURLConnection *, NSURLProtectionSpace *))block {
    self.authenticationAgainstProtectionSpace = block;
}

- (void)setAuthenticationChallengeBlock:(void (^)(NSURLConnection *connection, NSURLAuthenticationChallenge *challenge))block {
    self.authenticationChallenge = block;
}

- (void)setCacheResponseBlock:(NSCachedURLResponse * (^)(NSURLConnection *connection, NSCachedURLResponse *cachedResponse))block {
    self.cacheResponse = block;
}

- (void)setRedirectResponseBlock:(NSURLRequest * (^)(NSURLConnection *connection, NSURLRequest *request, NSURLResponse *redirectResponse))block {
    self.redirectResponse = block;
}

- (void)setState:(ONAFOperationState)state {
    [self.lock lock];
    if (ONAFStateTransitionIsValid(self.state, state, [self isCancelled])) {
        NSString *oldStateKey = ONAFKeyPathFromOperationState(self.state);
        NSString *newStateKey = ONAFKeyPathFromOperationState(state);
        
        [self willChangeValueForKey:newStateKey];
        [self willChangeValueForKey:oldStateKey];
        _state = state;
        [self didChangeValueForKey:oldStateKey];
        [self didChangeValueForKey:newStateKey];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (state) {
                case ONAFOperationExecutingState:
                    [[NSNotificationCenter defaultCenter] postNotificationName:ONAFNetworkingOperationDidStartNotification object:self];
                    break;
                case ONAFOperationFinishedState:
                    [[NSNotificationCenter defaultCenter] postNotificationName:ONAFNetworkingOperationDidFinishNotification object:self];
                    break;
                default:
                    break;
            }
        });
    }
    [self.lock unlock];
}

- (NSString *)responseString {
    [self.lock lock];
    if (!_responseString && self.response && self.responseData) {
        self.responseString = [[NSString alloc] initWithData:self.responseData encoding:self.responseStringEncoding];
    }
    [self.lock unlock];
    
    return _responseString;
}

- (NSStringEncoding)responseStringEncoding {
    [self.lock lock];
    if (!_responseStringEncoding && self.response) {
        NSStringEncoding stringEncoding = NSUTF8StringEncoding;
        if (self.response.textEncodingName) {
            CFStringEncoding IANAEncoding = CFStringConvertIANACharSetNameToEncoding((__bridge CFStringRef)self.response.textEncodingName);
            if (IANAEncoding != kCFStringEncodingInvalidId) {
                stringEncoding = CFStringConvertEncodingToNSStringEncoding(IANAEncoding);
            }
        }
        
        self.responseStringEncoding = stringEncoding;
    }
    [self.lock unlock];
    
    return _responseStringEncoding;
}

- (void)pause {
    if ([self isPaused] || [self isFinished] || [self isCancelled]) {
        return;
    }
    
    [self.lock lock];
    
    if ([self isExecuting]) {
        [self.connection performSelector:@selector(cancel) onThread:[[self class] networkRequestThread] withObject:nil waitUntilDone:NO modes:[self.runLoopModes allObjects]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:ONAFNetworkingOperationDidFinishNotification object:self];
        });
    }
    
    self.state = ONAFOperationPausedState;

    [self.lock unlock];
}

- (BOOL)isPaused {
    return self.state == ONAFOperationPausedState;
}

- (void)resume {
    if (![self isPaused]) {
        return;
    }
    
    [self.lock lock];
    self.state = ONAFOperationReadyState;
    
    [self start];
    [self.lock unlock];
}

#pragma mark - NSOperation

- (BOOL)isReady {
    return self.state == ONAFOperationReadyState && [super isReady];
}

- (BOOL)isExecuting {
    return self.state == ONAFOperationExecutingState;
}

- (BOOL)isFinished {
    return self.state == ONAFOperationFinishedState;
}

- (BOOL)isConcurrent {
    return YES;
}

- (void)start {
    [self.lock lock];
    if ([self isReady]) {
        self.state = ONAFOperationExecutingState;
        
        [self performSelector:@selector(operationDidStart) onThread:[[self class] networkRequestThread] withObject:nil waitUntilDone:NO modes:[self.runLoopModes allObjects]];
    }
    [self.lock unlock];
}

- (void)operationDidStart {
    [self.lock lock];
    if ([self isCancelled]) {
        [self finish];
    } else {
#if TARGET_OS_WATCH
        NSURLConnection *connection = [[NSURLConnection alloc] init];

        /* NOTE: this is a hack for making NSURLConnection working on watchOS. */
        SEL sel = sel_registerName("initWithRequest:delegate:startImmediately:");
        id(*initializer)(id, SEL, ...) = (id(*)(id, SEL, ...))class_getMethodImplementation([NSURLConnection class], sel);
        initializer(connection, sel, self.request, self, NO);

        self.connection = connection;
#else
        self.connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self startImmediately:NO];
#endif
        
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        for (NSString *runLoopMode in self.runLoopModes) {
            [self.connection scheduleInRunLoop:runLoop forMode:runLoopMode];
            [self.outputStream scheduleInRunLoop:runLoop forMode:runLoopMode];
        }
        
        [self.connection start];  
    }
    [self.lock unlock];
}

- (void)finish {
    self.state = ONAFOperationFinishedState;
}

- (void)cancel {
    [self.lock lock];
    if (![self isFinished] && ![self isCancelled]) {
        [self willChangeValueForKey:@"isCancelled"];
        _cancelled = YES;
        [super cancel];
        [self didChangeValueForKey:@"isCancelled"];

        // Cancel the connection on the thread it runs on to prevent race conditions 
        [self performSelector:@selector(cancelConnection) onThread:[[self class] networkRequestThread] withObject:nil waitUntilDone:NO modes:[self.runLoopModes allObjects]];
    }
    [self.lock unlock];
}

- (void)cancelConnection {
    NSDictionary *userInfo = nil;
    if ([self.request URL]) {
        userInfo = [NSDictionary dictionaryWithObject:[self.request URL] forKey:NSURLErrorFailingURLErrorKey];
    }
    self.error = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorCancelled userInfo:userInfo];

    if (self.connection) {
        [self.connection cancel];
        
        // Manually send this delegate message since `[self.connection cancel]` causes the connection to never send another message to its delegate
        [self performSelector:@selector(connection:didFailWithError:) withObject:self.connection withObject:self.error];
    }
}

#pragma mark - NSURLConnectionDelegate

#ifdef _ONAFNETWORKING_PIN_SSL_CERTIFICATES_
- (void)connection:(NSURLConnection *)connection
willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        SecTrustRef serverTrust = challenge.protectionSpace.serverTrust;
        SecCertificateRef certificate = SecTrustGetCertificateAtIndex(serverTrust, 0);
        NSData *certificateData = (__bridge_transfer NSData *)SecCertificateCopyData(certificate);
        
        if ([[[self class] pinnedCertificates] containsObject:certificateData]) {
            NSURLCredential *credential = [NSURLCredential credentialForTrust:serverTrust];
            [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
        } else {
            [[challenge sender] cancelAuthenticationChallenge:challenge];
        }
    }
}
#endif

- (BOOL)connection:(NSURLConnection *)connection 
canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
#ifdef _ONAFNETWORKING_ALLOW_INVALID_SSL_CERTIFICATES_
    if ([protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        return YES;
    }
#endif
    
    if (self.authenticationAgainstProtectionSpace) {
        return self.authenticationAgainstProtectionSpace(connection, protectionSpace);
    } else if ([protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust] || [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodClientCertificate]) {
        return NO;
    } else {
        return YES;
    }
}

- (void)connection:(NSURLConnection *)connection 
didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge 
{
#ifdef _ONAFNETWORKING_ALLOW_INVALID_SSL_CERTIFICATES_
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        return;
    }
#endif
    
    if (self.authenticationChallenge) {
        self.authenticationChallenge(connection, challenge);
    } else {
        if ([challenge previousFailureCount] == 0) {
            NSURLCredential *credential = nil;
            
            NSString *username = (__bridge_transfer NSString *)CFURLCopyUserName((__bridge CFURLRef)[self.request URL]);
            NSString *password = (__bridge_transfer NSString *)CFURLCopyPassword((__bridge CFURLRef)[self.request URL]);
            
            if (username && password) {
                credential = [NSURLCredential credentialWithUser:username password:password persistence:NSURLCredentialPersistenceNone];
            } else if (username) {
                credential = [[[NSURLCredentialStorage sharedCredentialStorage] credentialsForProtectionSpace:[challenge protectionSpace]] objectForKey:username];
            } else {
                credential = [[NSURLCredentialStorage sharedCredentialStorage] defaultCredentialForProtectionSpace:[challenge protectionSpace]];
            }
            
            if (credential) {
                [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
            } else {
                [[challenge sender] continueWithoutCredentialForAuthenticationChallenge:challenge];
            }
        } else {
            [[challenge sender] continueWithoutCredentialForAuthenticationChallenge:challenge];
        }
    }
}

- (NSURLRequest *)connection:(NSURLConnection *)connection
             willSendRequest:(NSURLRequest *)request
            redirectResponse:(NSURLResponse *)redirectResponse
{
    if (self.redirectResponse) {
        return self.redirectResponse(connection, request, redirectResponse);
    } else {
        return request;
    }
}

- (void)connection:(NSURLConnection __unused *)connection
   didSendBodyData:(NSInteger)bytesWritten
 totalBytesWritten:(NSInteger)totalBytesWritten 
totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    if (self.uploadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.uploadProgress(self, (NSUInteger)bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
        });
    }
}

- (void)connection:(NSURLConnection __unused *)connection
didReceiveResponse:(NSURLResponse *)response 
{
    self.response = response;
    
    [self.outputStream open];
}

- (void)connection:(NSURLConnection __unused *)connection
    didReceiveData:(NSData *)data
{
    self.totalBytesRead += [data length];
    
    if ([self.outputStream hasSpaceAvailable]) {
        const uint8_t *dataBuffer = (uint8_t *) [data bytes];
        [self.outputStream write:&dataBuffer[0] maxLength:[data length]];
    }
    
    if (self.downloadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.downloadProgress(self, [data length], self.totalBytesRead, self.response.expectedContentLength);
        });
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection __unused *)connection {
    self.responseData = [self.outputStream propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
    
    [self.outputStream close];
    
    [self finish];

    self.connection = nil;
}

- (void)connection:(NSURLConnection __unused *)connection
  didFailWithError:(NSError *)error 
{    
    self.error = error;
    
    [self.outputStream close];
    
    [self finish];

    self.connection = nil;
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection 
                  willCacheResponse:(NSCachedURLResponse *)cachedResponse 
{
    if (self.cacheResponse) {
        return self.cacheResponse(connection, cachedResponse);
    } else {
        if ([self isCancelled]) {
            return nil;
        }
        
        return cachedResponse; 
    }
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
    NSURLRequest *request = [aDecoder decodeObjectForKey:@"request"];
    
    self = [self initWithRequest:request];
    if (!self) {
        return nil;
    }

    self.state = (ONAFOperationState)[aDecoder decodeIntegerForKey:@"state"];
    self.cancelled = [aDecoder decodeBoolForKey:@"isCancelled"];
    self.response = [aDecoder decodeObjectForKey:@"response"];
    self.error = [aDecoder decodeObjectForKey:@"error"];
    self.responseData = [aDecoder decodeObjectForKey:@"responseData"];
    self.totalBytesRead = [[aDecoder decodeObjectForKey:@"totalBytesRead"] longLongValue];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self pause];
    
    [aCoder encodeObject:self.request forKey:@"request"];

    switch (self.state) {
        case ONAFOperationExecutingState:
        case ONAFOperationPausedState:
            [aCoder encodeInteger:ONAFOperationReadyState forKey:@"state"];
            break;
        default:
            [aCoder encodeInteger:self.state forKey:@"state"];
            break;
    }
    
    [aCoder encodeBool:[self isCancelled] forKey:@"isCancelled"];
    [aCoder encodeObject:self.response forKey:@"response"];
    [aCoder encodeObject:self.error forKey:@"error"];
    [aCoder encodeObject:self.responseData forKey:@"responseData"];
    [aCoder encodeObject:[NSNumber numberWithLongLong:self.totalBytesRead] forKey:@"totalBytesRead"];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    ONAFURLConnectionOperation *operation = [(ONAFURLConnectionOperation *)[[self class] allocWithZone:zone] initWithRequest:self.request];
            
    operation.uploadProgress = self.uploadProgress;
    operation.downloadProgress = self.downloadProgress;
    operation.authenticationAgainstProtectionSpace = self.authenticationAgainstProtectionSpace;
    operation.authenticationChallenge = self.authenticationChallenge;
    operation.cacheResponse = self.cacheResponse;
    operation.redirectResponse = self.redirectResponse;

    return operation;
}

@end
