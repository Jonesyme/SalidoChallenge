//
//  ProductDetailTableViewCell.m
//  Salido
//
//  Created by Mike on 5/13/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import "ProductDetailTableViewCell.h"

@implementation ProductDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
-(void)configureCellContent:(NSString *)propertyName propertyValue:(NSString *)propertyValue {
    _nameLabel.text = propertyName;
    _valueLabel.text = propertyValue;
}
@end
