//
//  ShoppingCartTotalCell.h
//  Salido
//
//  Created by Mike on 5/12/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCartTotalCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *totalPriceLbl;
-(void)configureCellContent;
@end
