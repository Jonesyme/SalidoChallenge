//
//  SearchVC.h
//  Salido
//
//  Created by Mike on 5/8/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "ShoppingCartUpdateProtocol.h"

@interface SearchVC : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, ShoppingCartUpdateDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
// top toolbar buttons
@property (nonatomic, weak) IBOutlet UIButton *TBToggleFiltersBtn;
@property (nonatomic, weak) IBOutlet UIButton *TBSearchBtn;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *TBSearchSpinner;
@property (nonatomic, weak) IBOutlet UIButton *TBShoppingCartItemCountBtn;

// member variables
@property (atomic, strong) NSMutableArray<Product *> * productList; // array of Products returned from search
@property (atomic, strong) NSString * selectedCategoryFilter;        // selected category filter
@property (atomic, strong) NSString * sortExp; // sort expression
@property (atomic, strong) NSString * sortDir; // sort direction

-(IBAction)toolbarToggleFiltersBtnTapped:(id)sender;
-(IBAction)toolbarSearchBtnTapped:(id)sender;
-(IBAction)toolbarShoppingCartBtnTapped:(id)sender;
-(IBAction)logoutBtnTapped:(id)sender;

/** 
 Enable external VC to modify search filer selection (primarily the slide-out category view)
 */
-(void)setSelectedCategoryFilter:(NSString *)filter;

-(void)executeSearchQuery;
-(void)reloadTableView;

@end
