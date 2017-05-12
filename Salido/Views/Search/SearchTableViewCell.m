//
//  SearchTableViewCell.m
//  Salido
//
//  Created by Mike on 5/8/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import "SearchTableViewCell.h"
#import "ShoppingCartManager.h"
#import "NSNumber+CurrencyString.h"

@implementation SearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)configureCellContent {
    _titleLbl.text = _product.Name;
    _priceLbl.text = [_product.PriceRetail currencyFormattedString];
    
    _qtyLbl.text = @"1";
    _itemImageView.image = [UIImage imageNamed:@"productThumb"];
}

-(IBAction)addToCartTapped:(id)sender {
    if(_product!=nil) {
        int qty = [_qtyLbl.text intValue];
        [[ShoppingCartManager sharedInstance] addLineItem:_product quantity:[NSNumber numberWithInt:qty]];
    }
}

@end
