//
//  ProductDetailVC.m
//  Salido
//
//  Created by Mike on 5/8/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import "ProductDetailVC.h"
#import "ShoppingCartManager.h"
#import "ShoppingCartVC.h"
#import "ProductDetailTableViewCell.h"
#import "headers.h"

@interface ProductDetailVC ()
@end

@implementation ProductDetailVC

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        _product = nil;
        _productPropertyList = nil;
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    _stepperCtrl.value = 1;
    _stepperCtrl.minimumValue = 1;
    _stepperCtrl.stepValue = 1;
    
    // add shadow to item image view
    _itemImageView.layer.shadowColor = [[UIColor blackColor] CGColor];
    _itemImageView.layer.shadowOffset = CGSizeMake(1.00, 1.00);
    _itemImageView.layer.shadowOpacity = 1;
    _itemImageView.layer.shadowRadius = 9;
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _stepperCtrl.value = 1;
    [self configureProductDetailsForDisplay];
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
-(void)configureProductDetailsForDisplay {
    // construct product-properties array for table
    _productPropertyList = [[NSMutableArray alloc] init];
    [_productPropertyList addObject:@{    @"name":@"Region",         @"value":_product.Appellation.Region.Name}];
    [_productPropertyList addObject:@{    @"name":@"Appellation",    @"value":_product.Appellation.Name}];
    [_productPropertyList addObject:@{    @"name":@"Vintage",        @"value":_product.Vintage}];
    //[_productPropertyList addObject:@{    @"name":@"Type",           @"value":_product.Type}];
    [_productPropertyList addObject:@{    @"name":@"Wine Type",      @"value":_product.Varietal.WineType.Name}];
    [_productPropertyList addObject:@{    @"name":@"Varietal",       @"value":_product.Varietal.Name}];
    [_productPropertyList addObject:@{    @"name":@"Vineyard",       @"value":_product.Vineyard.Name}];
    if(_product.Description != nil && ![_product.Description isEqualToString:@""])
        [_productPropertyList addObject:@{@"name":@"Description",    @"value":_product.Description}];
    if(_product.ProductAttributes != nil && [_product.ProductAttributes count] >= 1)
        [_productPropertyList addObject:@{@"name":@"Attributes",     @"value":_product.ProductAttributes[0].Name}];
    [_productPropertyList addObject:@{    @"name":@"PriceMin",       @"value":[_product.PriceMin currencyFormattedString]}];
    [_productPropertyList addObject:@{    @"name":@"PriceMax",       @"value":[_product.PriceMax currencyFormattedString]}];
    if(![[_product.Ratings.HighestScore stringValue] isEqualToString:@"0"])
        [_productPropertyList addObject:@{    @"name":@"Highest Rating", @"value":[_product.Ratings.HighestScore stringValue]}];
    [self reloadProductPropertiesTable];
    
    // configure outletsa
    _TBProductNameLbl.text = _product.Name;
    _itemPriceLbl.text = [_product.PriceRetail currencyFormattedString];
    NSUInteger value = _stepperCtrl.value;
    _qtyToAddLbl.text = [NSString stringWithFormat:@"%lu",(unsigned long)value];
    
    // fetch vineyard/label image asyncronously
    _itemImageView.image = nil;
    if(_product.Labels!=nil && [_product.Labels count]>0) {
        NSString * imageURL = _product.Vineyard.ImageUrl; // use vineyard image first
        if(imageURL==nil || [imageURL isEqualToString:@""])
            imageURL = _product.Labels[0].Url; // fallback to bottle label if vineyard image not available
        [UIImage downloadFromURL:[NSURL URLWithString:imageURL] callback:^(UIImage *image) {
            _itemImageView.image = image;
        }];
    }
}
-(void)reloadProductPropertiesTable {
    [_tableView reloadData];
}

-(IBAction)toolbarShoppingCartBtnTapped:(id)sender {
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ShoppingCartVC * shoppingCartVC = (ShoppingCartVC *)[storyboard instantiateViewControllerWithIdentifier:@"shoppingCarVC"];
    [self.navigationController pushViewController:shoppingCartVC animated:true];
}
-(IBAction)valueDidChanged:(UIStepper *)sender {
    NSUInteger value = sender.value;
    _qtyToAddLbl.text = [NSString stringWithFormat:@"%lu",(unsigned long)value];
}
-(IBAction)addToCartTapped:(id)sender {
    if(_product!=nil) {
        int qty = [_qtyToAddLbl.text intValue];
        [[ShoppingCartManager sharedInstance] addLineItem:_product quantity:[NSNumber numberWithInt:qty]];
    }
}
#
#pragma mark - UITableViewDelegates
#
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_productPropertyList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"productDetailCell" forIndexPath:indexPath];
    if(cell==nil)
        cell = [[ProductDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"productDetailCell"];
    NSDictionary * properties = [_productPropertyList objectAtIndex:indexPath.row];
    [cell configureCellContent:[properties valueForKey:@"name"] propertyValue:[properties valueForKey:@"value"]];
    return cell;
}

#
#pragma mark - ShoppingCartUpdateDelegate
#
-(void)shoppingCartHasBeenUpdated:(ShoppingCartManager *)shoppingCartManager {
    NSNumber * productCount = [[ShoppingCartManager sharedInstance] fetchShoppingCartItemCount];
    [_TBShoppingCartItemCountBtn setTitle:[productCount stringValue] forState:UIControlStateNormal];
}

@end


