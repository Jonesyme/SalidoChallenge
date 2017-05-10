//
//  SearchTableViewCell.h
//  Salido
//
//  Created by Mike on 5/8/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface SearchTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *titleLbl;
@property (nonatomic, weak) IBOutlet UILabel *qtyLbl;
@property (nonatomic, weak) IBOutlet UILabel *priceLbl;
@property (nonatomic, weak) IBOutlet UIImageView *itemImageView;
@property (nonatomic, weak) IBOutlet UIStepper *stepperCtrl;
@property (nonatomic, weak) IBOutlet UIButton *addToCartBtn;

@property (atomic, weak) Product * product; // data model object

-(void)configureCellContent;
-(IBAction)addToCartTapped:(id)sender;

@end
