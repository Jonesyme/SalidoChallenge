//
//  CartItem.h
//  Salido
//
//  Created by Mike on 5/12/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"

/**
 Shopping Cart Item Store
 */
@interface CartItem : NSObject
@property (atomic, strong) Product * product;
@property (atomic, strong) NSNumber * quantity;

/**
 Essentially retailprice * quantity
 */
-(NSNumber *)itemSubTotal;

@end
