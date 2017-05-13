//
//  CartItem.m
//  Salido
//
//  Created by Mike on 5/12/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import "CartItem.h"

@implementation CartItem

-(NSNumber *)itemSubTotal {
    return [NSNumber numberWithFloat:([_product.PriceRetail floatValue] * [_quantity floatValue])];
}
@end
