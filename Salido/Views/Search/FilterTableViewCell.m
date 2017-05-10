//
//  FilterTableViewCell.m
//  Salido
//
//  Created by Mike on 5/8/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import "FilterTableViewCell.h"

@interface FilterTableViewCell ()
@end

@implementation FilterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _subCategory = nil;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)configureCellContent {
    if(_subCategory!=nil)
        self.textLabel.text = _subCategory.Name;
}

@end
