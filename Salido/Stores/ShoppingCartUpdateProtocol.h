//
//  ShoppingCartUpdateProtocol.h
//  Salido
//
//  Created by Mike on 5/12/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

//#ifndef ShoppingCartUpdateProtocol_h
//#define ShoppingCartUpdateProtocol_h

@class ShoppingCartManager;

/**
 To be used as Shopping cart update delegate
 */
@protocol ShoppingCartUpdateDelegate <NSObject>

-(void)shoppingCartHasBeenUpdated:(ShoppingCartManager *)shoppingCartManager;

@end

//#endif /* ShoppingCartUpdateProtocol_h */
