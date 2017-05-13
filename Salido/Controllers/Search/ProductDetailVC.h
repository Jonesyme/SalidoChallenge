//
//  ProductDetailVC.h
//  Salido
//
//  Created by Mike on 5/8/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartUpdateProtocol.h"
#import "Product.h"

@interface ProductDetailVC : UIViewController <UITableViewDelegate, UITableViewDataSource, ShoppingCartUpdateDelegate>
// interface outlets
@property (nonatomic, weak) IBOutlet UILabel     * TBProductNameLbl;            // toolbar product name label
@property (nonatomic, weak) IBOutlet UIButton    * TBShoppingCartItemCountBtn;  // toolbar shopping cart item count button
@property (nonatomic, weak) IBOutlet UIImageView * itemImageView;               // item image view
@property (nonatomic, weak) IBOutlet UILabel     * itemPriceLbl;                // item unit price label
@property (nonatomic, weak) IBOutlet UILabel     * qtyToAddLbl;                 // quantity to add label
@property (nonatomic, weak) IBOutlet UIStepper   * stepperCtrl;                 // UIStepper control to change quantity to add
@property (nonatomic, weak) IBOutlet UIButton    * addToCartBtn;                // add to cart button
@property (nonatomic, weak) IBOutlet UITableView * tableView;                   // product properties table view
@property (nonatomic, strong) NSMutableArray<NSDictionary *> * productPropertyList; // product properties for table view
// member variables
@property (nonatomic, strong) Product * product; // product detail to display
// member functions
/** 
 Initializer
 */
-(id)initWithCoder:(NSCoder *)aDecoder;
/**
 Toolbar shopping cart button tapped 
 Note: Action used by both cart-icon and item-count buttons
 */
-(IBAction)toolbarShoppingCartBtnTapped:(id)sender;
/**
 UIStepper control value did change action
 */
-(IBAction)valueDidChanged:(UIStepper *)sender;
/**
 Add product of selectecd quantity to shopping cart
 */
-(IBAction)addToCartTapped:(id)sender;

-(void)configureProductDetailsForDisplay;
-(void)reloadProductPropertiesTable;

@end
