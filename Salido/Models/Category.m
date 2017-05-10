//
//  Category.m
//  Salido
//
//  Created by Mike on 5/9/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Category.h"
#import "JSONJoy.h"

@implementation SubCategory
@end

@implementation Category
+(JSONJoy*)jsonMapper {
    JSONJoy* mapper = [[JSONJoy alloc] initWithClass:[self class]];
    [mapper addArrayClassMap:@"Refinements" class:[SubCategory class]];
    return mapper;
}
@end

@implementation CategoryResponseObject
+(JSONJoy*)jsonMapper {
    JSONJoy* mapper = [[JSONJoy alloc] initWithClass:[self class]];
    [mapper addArrayClassMap:@"Categories" class:[Category class]];
    return mapper;
}
@end
