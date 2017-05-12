//
//  ShoppingCartTableViewCell.m
//  Salido
//
//  Created by Mike on 5/8/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import "ShoppingCartTableViewCell.h"
#import "ShoppingCartManager.h"
#import "NSNumber+CurrencyString.h"

@implementation ShoppingCartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)configureCellContent {
    _titleLbl.text = _cartItem.product.Name;
    _qtyLbl.text = [_cartItem.quantity stringValue];
    _priceLbl.text = [[_cartItem itemSubTotal] currencyFormattedString];
    _itemImageView.image = [UIImage imageNamed:@"productThumb"];
}

-(IBAction)deleteLineItem:(id)sender {
    [[ShoppingCartManager sharedInstance] removeLineItem:_cartItem.product.Id quantity:nil];
}
@end
