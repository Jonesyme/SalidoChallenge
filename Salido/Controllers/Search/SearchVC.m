//
//  SearchVC.m
//  Salido
//
//  Created by Mike on 5/8/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import "SearchVC.h"
#import "SearchTableVIewCell.h"
#import "Product.h"
#import "SWRevealViewController.h"
#import "WineWebService.h"
#import "FilterVC.h"
#import "ProductDetailVC.h"
#import "UIImage+DownloadImg.h"
#import "ShoppingCartManager.h"
#import "ShoppingCartVC.h"

@interface SearchVC ()
-(void)reloadTableView;
@end


@implementation SearchVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.revealViewController.rearViewRevealWidth = 320;
    if(self.revealViewController ){
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _searchBar.delegate = self;
    _selectedCategoryFilter = nil;
    [self executeSearchQuery];
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _TBSearchSpinner.hidden = true;
    _TBSearchBtn.hidden = false;
    [_TBShoppingCartItemCountBtn setTitle:[[[ShoppingCartManager sharedInstance] fetchShoppingCartItemCount] stringValue] forState:UIControlStateNormal];
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[ShoppingCartManager sharedInstance] setDelegate:self];
}
-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[ShoppingCartManager sharedInstance] setDelegate:nil];
}

-(void)executeSearchQuery {
    // show activity spinner
    [_searchBar resignFirstResponder];
    _TBSearchSpinner.hidden = false;
    _TBSearchBtn.hidden = true;
    [_TBSearchSpinner startAnimating];
    // fetch products from remote wine.com web-service
    [[WineWebService sharedInstance] searchForProductsWithFilter:_selectedCategoryFilter searchString:_searchBar.text completion:^void (SearchResponseObject *response, NSError *error) {
        if(error!=nil) {
            NSLog(@"WineAPI General Error: %@", error.description);
            
            // API error alert
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Unable to reach Wine.com API.  Retry?" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self executeSearchQuery];
            }];
            [alert addAction:actionNo];
            [alert addAction:actionYes];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            self.productList = [response.Products.List mutableCopy];
            [self reloadTableView];
        }
        // hide activity spinner
        [_TBSearchSpinner stopAnimating];
        _TBSearchSpinner.hidden = true;
        _TBSearchBtn.hidden = false;
    }];
}
-(void)reloadTableView {
    [_tableView reloadData];
}

-(IBAction)toolbarToggleFiltersBtnTapped:(id)sender {
    [_searchBar resignFirstResponder];
    [self.revealViewController revealToggle:self];
}
-(IBAction)toolbarSearchBtnTapped:(id)sender {
    [self executeSearchQuery];
}
-(IBAction)toolbarShoppingCartBtnTapped:(id)sender {
    [_searchBar resignFirstResponder];
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ShoppingCartVC * shoppingCartVC = (ShoppingCartVC *)[storyboard instantiateViewControllerWithIdentifier:@"shoppingCarVC"];
    [self.revealViewController.navigationController pushViewController:shoppingCartVC animated:true];
}
-(IBAction)logoutBtnTapped:(id)sender {
    
}
#
#pragma mark - Table view data source
#
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_productList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"searchCell" forIndexPath:indexPath];
    if(cell==nil)
        cell = [[SearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"searchCell"];
    cell.product = [_productList objectAtIndex:indexPath.row];
    [cell configureCellContent];
    //cell.delegate = self; // add to cart callback delegate
    
    // fetch label image asyncronously
    if(cell.product.Labels!=nil && [cell.product.Labels count]>0) {
        NSString * labelImageURL = cell.product.Labels[0].Url;
        [UIImage downloadFromURL:[NSURL URLWithString:labelImageURL] callback:^(UIImage *image) {
            // verify cell is still visible
            SearchTableViewCell * tempCell = (SearchTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            if(tempCell!=nil) {
                tempCell.itemImageView.image = image;
            }
        }];
    }
    return cell;
}


#
#pragma mark - UISearchBarDelegate
#
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self executeSearchQuery];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar {
    [self executeSearchQuery];
}

#pragma mark - ShoppingCartUpdateDelegate
-(void)shoppingCartHasBeenUpdated:(ShoppingCartManager *)shoppingCartManager {
    NSNumber * productCount = [[ShoppingCartManager sharedInstance] fetchShoppingCartItemCount];
    [_TBShoppingCartItemCountBtn setTitle:[productCount stringValue] forState:UIControlStateNormal];
}
@end
