//
//  FilterTableViewCell.h
//  Salido
//
//  Created by Mike on 5/8/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Category.h"

/**
 Each cell will represent a filterable "SubCategory" from our WineAPI data model.
 Table sections will represent the top-level "Categories"
 */
@interface FilterTableViewCell : UITableViewCell
@property (nonatomic, weak) SubCategory * subCategory;
/**
 configure cell with data model attributes for display
 */
-(void)configureCellContent;

@end
