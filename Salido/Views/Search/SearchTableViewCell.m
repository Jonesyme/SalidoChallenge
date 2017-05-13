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
    _stepperCtrl.minimumValue = 1;
    _stepperCtrl.stepValue = 1;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)configureCellContent {
    _titleLbl.text = _product.Name;
    _priceLbl.text = [_product.PriceRetail currencyFormattedString];
    _qtyLbl.text = @"1";
    _stepperCtrl.value = 1;
    _itemImageView.image = [UIImage imageNamed:@"productThumb"];
}
-(IBAction)valueDidChanged:(UIStepper *)sender {
    NSUInteger value = sender.value;
    _qtyLbl.text = [NSString stringWithFormat:@"%lu",value];
}
-(IBAction)addToCartTapped:(id)sender {
    if(_product!=nil) {
        int qty = [_qtyLbl.text intValue];
        [[ShoppingCartManager sharedInstance] addLineItem:_product quantity:[NSNumber numberWithInt:qty]];
    }
}

@end
