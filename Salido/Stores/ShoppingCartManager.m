//
//  ShoppingCartManager.m
//  Salido
//
//  Created by Mike on 5/9/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import "ShoppingCartManager.h"

@interface ShoppingCartManager ()

@end

@implementation ShoppingCartManager


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
        [self emptyCart];
        self.delegate = nil;
    }
    return self;
}

-(void)emptyCart {
    _itemList = [[NSMutableArray alloc] init];
}

-(void)addLineItem:(Product *)product quantity:(NSNumber *)quantity {
    // if product is already in cart, increment that line-item's quantity
    for(CartItem * lineItem in _itemList) {
        if([lineItem.product.Id isEqualToNumber:product.Id]) {
            lineItem.quantity = [NSNumber numberWithInt:[lineItem.quantity intValue] + [quantity intValue]];
            lineItem.itemPriceTotal = [NSNumber numberWithFloat:([lineItem.product.PriceRetail floatValue] * [quantity floatValue])];
            [_delegate shoppingCartHasBeenUpdated:self];
            return;
        }
    }
    // otherwise, add new line item
    CartItem * item = [[CartItem alloc] init];
    item.product = product;
    item.quantity = quantity;
    item.itemPriceTotal = [NSNumber numberWithFloat:([product.PriceRetail floatValue] * [quantity floatValue])];
    [_itemList addObject:item];
    [_delegate shoppingCartHasBeenUpdated:self];
    return;
}

-(void)removeLineItem:(NSNumber *)productID quantity:(NSNumber *)qtyToRemove {
    // find line-item and reduce quantity - if resulting qty <=0 or qtyToRemove==nil, remove line-item record altogether
    CartItem * itemToRemove = nil;
    for(CartItem * lineItem in _itemList) {
        if([lineItem.product.Id isEqualToNumber:productID]) {
            if(qtyToRemove==nil || ([lineItem.quantity intValue] - [qtyToRemove intValue]) <= 0) {
                itemToRemove = lineItem;
            } else {
                lineItem.quantity = [NSNumber numberWithInt:[lineItem.quantity intValue] - [qtyToRemove intValue]];
                lineItem.itemPriceTotal = [NSNumber numberWithFloat:([lineItem.product.PriceRetail floatValue] * [lineItem.quantity floatValue])];
            }
            break;
        }
    }
    // if qty <= 0, remove them line-item altogether
    if(itemToRemove!=nil) {
        [_itemList removeObject:itemToRemove];
    }
    [_delegate shoppingCartHasBeenUpdated:self];
}

-(NSArray<CartItem *> *)fetchShoppingCartItems {
    return _itemList;
}

-(NSNumber *)fetchShoppingCartPriceTotal {
    float priceTotal = 0;
    for(CartItem * lineItem in _itemList) {
        priceTotal += [lineItem.product.PriceRetail floatValue] * [lineItem.quantity floatValue];
    }
    return [NSNumber numberWithFloat:priceTotal];
}

-(NSNumber *)fetchShoppingCartItemCount {
    int productCount = 0;
    for(CartItem * lineItem in _itemList) {
        productCount += [lineItem.quantity intValue];
    }
    return [NSNumber numberWithInt:productCount];
}
@end
