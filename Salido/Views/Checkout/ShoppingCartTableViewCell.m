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
    _stepperCtrl.minimumValue = 1;
    _stepperCtrl.stepValue = 1;
}

-(void)configureCellContent {
    _titleLbl.text = _cartItem.product.Name;
    _qtyLbl.text = [_cartItem.quantity stringValue];
    _stepperCtrl.value = [_cartItem.quantity intValue];
    _priceLbl.text = [[_cartItem itemSubTotal] currencyFormattedString];
    _itemImageView.image = [UIImage imageNamed:@"productThumb"];
}

-(IBAction)valueDidChanged:(UIStepper *)sender {
    int originalValue = [_qtyLbl.text intValue];
    int newValue = (int)sender.value;
    _qtyLbl.text= [NSString stringWithFormat:@"%d", newValue];
    if(originalValue > newValue)
        [[ShoppingCartManager sharedInstance] removeLineItem:_cartItem.product.Id quantity:[NSNumber numberWithInt:1]];
    else
        [[ShoppingCartManager sharedInstance] addLineItem:_cartItem.product quantity:[NSNumber numberWithInt:1]];
}
/**
 Delete all quantities of this line item
 */
-(IBAction)deleteLineItem:(id)sender {
    [[ShoppingCartManager sharedInstance] removeLineItem:_cartItem.product.Id quantity:nil];
}

@end
