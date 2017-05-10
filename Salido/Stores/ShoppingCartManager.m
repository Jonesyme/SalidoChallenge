//
//  ShoppingCartManager.m
//  Salido
//
//  Created by Mike on 5/9/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import "ShoppingCartManager.h"
/**
 NOT IMPLEMENTED YET
 */
@implementation ShoppingCartManager

// shared singleton
+(id)sharedInstance {
    static ShoppingCartManager * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(id)init {
    self = [super init];
    if(self) {
        // init
    }
    return self;
}


@end
