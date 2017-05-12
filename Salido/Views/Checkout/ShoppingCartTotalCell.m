//
//  ShoppingCartTotalCell.m
//  Salido
//
//  Created by Mike on 5/12/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import "ShoppingCartTotalCell.h"
#import "ShoppingCartManager.h"
#import "NSNumber+CurrencyString.h"

@implementation ShoppingCartTotalCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
-(void)configureCellContent {
    _totalPriceLbl.text = [[[ShoppingCartManager sharedInstance] fetchShoppingCartPriceTotal] currencyFormattedString];
}
@end
