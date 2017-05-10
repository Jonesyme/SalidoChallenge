//
//  BaseWebService.h
//  Salido
//
//  Created by Mike on 5/10/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Custom base class for WebService APIs
 Stores handle to NSURLSession and implements basic asynchronous HTTP request and GET parameter structuring
 */
@interface BaseWebService : NSObject <NSURLSessionDelegate>
// properties
@property (atomic, strong) NSURLSessionConfiguration * defaultConfigObject;
@property (atomic, strong) NSURLSession * defaultSession;
@property (nonatomic, strong) NSString * baseURL;
@property (nonatomic, strong) NSString * requestMethod;
/** 
 @param baseURL base host URL for WebService
 @param requestMethod GET,POST,PUT,etc.
 */
-(id)initWithBaseURL:(NSString *)baseURL requestMethod:(NSString *)requestMethod;
/**
 Optional request headers in dictionary form
 */
-(NSDictionary *)requestHeaders;
/**
 Format request parameters
 @param path relative path to postfix onto baseURL in order to reach resource path
 @param params optional request parameters or NIL if none specified
 */
-(NSURL *)formatRequestURLWithRelativePath:(NSString *)path parameters:(NSDictionary *)params;
/**
 Perform Asyncronise HTTP request
 @param path relative path postfixed onto baseURL to reach the desired resource
 @param parameters dictionary of optional request parameters
 @param completion - NSData result or NSError
 */
-(void)asyncHTTPRequestWithPath:(NSString *)path parameters:(NSDictionary *)parameters completion:(void (^)(NSData *, NSError *))completion;
/**
 Perform Asyncronise JSON request
 @param path relative path postfixed onto baseURL to reach the desired resource
 @param parameters dictionary of optional request parameters
 @param completion - NSDictionary of parsed JSON or NSError
 */
-(void)asyncJSONRequestWithPath:(NSString *)path parameters:(NSDictionary *)parameters completion:(void (^)(NSDictionary *, NSError *))completion;


@end


