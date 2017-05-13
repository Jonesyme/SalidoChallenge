//
//  Product.m
//  Salido
//
//  Created by Mike on 5/8/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import "Product.h"

#pragma mark - Response Wrappers
@implementation SearchResponseObject
@end
@implementation ProductResponseObject
+(JSONJoy*)jsonMapper {
    JSONJoy* mapper = [[JSONJoy alloc] initWithClass:[self class]];
    [mapper addArrayClassMap:@"List" class:[Product class]];
    return mapper;
}
@end

#pragma mark - Sub-Product Mappings
@implementation ProductAppellationRegion : NSObject
@end
@implementation ProductAppellation : NSObject
@end
@implementation ProductLabel : NSObject
@end
@implementation ProductVarietalWineType : NSObject
@end
@implementation ProductVarietal : NSObject
@end
@implementation ProductVineyard : NSObject
@end
@implementation ProductAttribute : NSObject
@end
@implementation ProductRating : NSObject
@end

#pragma mark - Product
@implementation Product
+(JSONJoy*)jsonMapper {
    JSONJoy* mapper = [[JSONJoy alloc] initWithClass:[self class]];
    [mapper addArrayClassMap:@"Labels" class:[ProductLabel class]];
    [mapper addArrayClassMap:@"ProductAttributes" class:[ProductAttribute class]];
    return mapper;
}

-(NSString *)getPriceCurrencyString {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    return [formatter stringFromNumber:_PriceRetail];
}
@end

