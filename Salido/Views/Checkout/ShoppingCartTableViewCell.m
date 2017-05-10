//
//  ShoppingCartTableViewCell.m
//  Salido
//
//  Created by Mike on 5/8/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import "ShoppingCartTableViewCell.h"

@implementation ShoppingCartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)configureCellContent {
    _titleLbl.text = _product.Name;
    _qtyLbl.text = @"1";
    _priceLbl.text = @"19.99";
    _itemImageView.image = [UIImage imageNamed:@"productThumb"];
}
@end
