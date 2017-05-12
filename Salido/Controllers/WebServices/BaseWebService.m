//
//  BaseWebService.m
//  Salido
//
//  Created by Mike on 5/10/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import "BaseWebService.h"

@implementation BaseWebService

-(id)initWithBaseURL:(NSString *)baseURL requestMethod:(NSString *)requestMethod {
    self = [super init];
    if(self) {
        _defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        _defaultSession = [NSURLSession sessionWithConfiguration:_defaultConfigObject delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        
        self.baseURL = baseURL;
        self.requestMethod = requestMethod;
    }
    return self;
}

-(NSDictionary *)requestHeaders {
    return nil;
}

-(NSURL *)formatRequestURLWithRelativePath:(NSString *)path parameters:(NSDictionary *)params {
    NSString * paramStr = [[self baseURL] stringByAppendingString:path];
    // append GET parameters to URL
    if([[self requestMethod] isEqual:@"GET"]) {
        bool firstParam = true;
        for(id key in params) {
            if(firstParam) {
                paramStr = [paramStr stringByAppendingString:@"?"];
                firstParam = false;
            }
            else
                paramStr = [paramStr stringByAppendingString:@"&"];
            
            paramStr = [paramStr stringByAppendingString:[NSString stringWithFormat:@"%@=%@", key, [params objectForKey:key]]];
        }
    }
    // encode url string
    NSLog(@"RawURL: %@", paramStr);
    NSString * encodedString = [paramStr stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    NSLog(@"EncodedURL: %@", encodedString);
    NSURL * url = [NSURL URLWithString:encodedString];
    return url;
}

-(void)asyncHTTPRequestWithPath:(NSString *)path parameters:(NSDictionary *)parameters completion:(void (^)(NSData *data, NSError *error))completion {
    // construct NSURLRequest from request path and parameters
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[self formatRequestURLWithRelativePath:path parameters:parameters]];
    [urlRequest setHTTPMethod:_requestMethod];
    [urlRequest setAllHTTPHeaderFields:[self requestHeaders]];
    if([[self requestMethod] isEqualToString:@"POST"]) {
        NSLog(@"Warning: POST request method with parameters not implemented");
    }
    // perform async request
    NSURLSessionDataTask * dataTask = [_defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        completion(data, error);
    }];
    [dataTask resume];
}

-(void)asyncJSONRequestWithPath:(NSString *)path parameters:(NSDictionary *)parameters completion:(void (^)(NSDictionary *, NSError *))completion {
    [self asyncHTTPRequestWithPath:path parameters:parameters completion:^(NSData *data, NSError *error) {
        if(error!=nil || data==nil) {
            completion(nil, error);
            return;
        }
        // parse JSON
        NSError * parserError = nil;
        NSDictionary * parsedJSONDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parserError];
        completion(parsedJSONDict, parserError);
    }];
}




@end
