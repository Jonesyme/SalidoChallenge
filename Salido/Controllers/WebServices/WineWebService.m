//
//  WineWebService.m
//  Salido
//
//  Created by Mike on 5/10/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import "WineWebService.h"

@implementation WineWebService

// shared singleton
+(id)sharedInstance {
    static WineWebService * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(id)init {
    // wine.com API credentials
    _wineHostURL = @"http://services.wine.com/api/beta2/service.svc/json/";
    _wineAPIKey = @"f8bc6c9bc563acfa0b169d13b20abc2f";

    // response caches
    _categoryCache = nil;

    self = [super initWithBaseURL:_wineHostURL requestMethod:@"GET"];
    return self;
}

-(void)fetchAllCategories:(void (^_Nullable)(CategoryResponseObject *, NSError *))completion {
    if(_categoryCache!=nil)
        completion(_categoryCache, nil); // return cached response if available

    NSDictionary * params = @{@"apiKey" : _wineAPIKey, @"filter" : @"categories(490)"};

    [self asyncJSONRequestWithPath:@"categorymap" parameters:params completion:^(NSDictionary *parsedJSONDict, NSError *error) {
        if(error!=nil || parsedJSONDict==nil) {
            if(completion!=nil)
                completion(nil, error); // request failed
        } else {
            // map object model
            NSError * jsonMappingError = nil;
            CategoryResponseObject * catResponseObj = [CategoryResponseObject objectWithJoy:parsedJSONDict error:&jsonMappingError];
            if(completion!=nil)
                completion(catResponseObj, jsonMappingError);
        }
    }];
}

-(void)searchForProductsWithFilter:(NSString *)categoryFilter searchString:(NSString *)searchStr completion:(void (^)(SearchResponseObject *, NSError *))completion {
    
    // build request parameter dictionary
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:_wineAPIKey forKey:@"apiKey"];
    [params setObject:@"50" forKey:@"size"];
    [params setObject:@"0" forKey:@"offset"];
    
    // category filter
    NSString * categoryParam = [NSString stringWithFormat:@"categories(%@)", categoryFilter];
    [params setObject:categoryParam forKey:@"filter"];
    
    if(searchStr!=nil)
       [params setObject:searchStr forKey:@"search"];

    // perform network request
    [self asyncJSONRequestWithPath:@"catalog" parameters:params completion:^(NSDictionary *parsedJSONDict, NSError *error) {
        if(error!=nil ) {
            completion(nil, error); // request failed
        } else {
            // map object model
            NSError * jsonMappingError = nil;
            SearchResponseObject * searchResponse = [SearchResponseObject objectWithJoy:parsedJSONDict error:&jsonMappingError];
            completion(searchResponse, jsonMappingError);
        }
    }];
}

@end
