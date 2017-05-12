//
//  ShoppingCartManager.h
//  Salido
//
//  Created by Mike on 5/9/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"
#import "CartItem.h"

#import "ShoppingCartUpdateProtocol.h"


/**
 Shopping Cart Manager
 */
@interface ShoppingCartManager : NSObject
@property (atomic, strong) NSMutableArray<CartItem *> * itemList;
@property (atomic, weak) id <ShoppingCartUpdateDelegate> delegate;

/**
 Singleton Initializer
 */
+(id)sharedInstance;

/**
 Empty all shopping cart items
 */
-(void)emptyCart;

/**
 Add product to shopping cart instance
 @param product to add
 @param quantity of product to add
 note: will ensure the new or existing line-item's `itemPriceTotal` is updated to reflect change
 */
-(void)addLineItem:(Product *)product quantity:(NSNumber *)quantity;

/**
 Remove line-item from shopping cart instance
 @param productID ID of product to remove
 @param qtyToRemove quantity to remove from cart, if NIL remove ALL of the specified line-items
 */
-(void)removeLineItem:(NSNumber *)productID quantity:(NSNumber *)qtyToRemove;

/**
 Returns array of items in current shopping cart with calculated subtotal prices for each line-item
 @return array of CartItem instances
 */
-(NSArray<CartItem *> *)fetchShoppingCartItems;

/**
 Fetch total price of all items in current shopping cart
 @return float price total
 */
-(NSNumber *)fetchShoppingCartPriceTotal;

/**
 Fetch total number of products in shopping
 @return integer product count
 */
-(NSNumber *)fetchShoppingCartItemCount;


@end
