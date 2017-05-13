//
//  ShoppingCartVC.m
//  Salido
//
//  Created by Mike on 5/8/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import "ShoppingCartVC.h"
#import "ShoppingCartManager.h"
#import "CartItem.h"
#import "ShoppingCartTableViewCell.h"
#import "ShoppingCartTotalCell.h"
#import "UIImage+DownloadImg.h"

@interface ShoppingCartVC ()
@property (atomic, strong) NSArray<CartItem *> * cartItems;
@end

@implementation ShoppingCartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateShoppingCartTable];
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[ShoppingCartManager sharedInstance] setDelegate:self];
}
-(void)viewDidDisappear:(BOOL)animated {
    [[ShoppingCartManager sharedInstance] setDelegate:nil];
}
-(void)updateShoppingCartTable {
    _cartItems = [[ShoppingCartManager sharedInstance] fetchShoppingCartItems];
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==0)
        return [_cartItems count];
    return 1; // total cell at bottom
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0) {
        ShoppingCartTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"shoppingCartCell" forIndexPath:indexPath];
        if(cell==nil)
            cell = [[ShoppingCartTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"shoppingCartCell"];
        CartItem * cartItem = [_cartItems objectAtIndex:indexPath.row];
        cell.cartItem = cartItem;
        [cell configureCellContent];
        
        //cell.delegate = self; // add to cart callback delegate
        
        // fetch label image asyncronously
        if(cell.cartItem.product.Labels!=nil && [cell.cartItem.product.Labels count]>0) {
            NSString * labelImageURL = cell.cartItem.product.Labels[0].Url;
            [UIImage downloadFromURL:[NSURL URLWithString:labelImageURL] callback:^(UIImage *image) {
                // verify cell is still visible
                ShoppingCartTableViewCell * tempCell = (ShoppingCartTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
                if(tempCell!=nil) {
                    tempCell.itemImageView.image = image;
                }
            }];
        }
        return cell;
    } else {
        // total cell at bottom of table
        ShoppingCartTotalCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cartTotalCell" forIndexPath:indexPath];
        if(cell==nil)
            cell = [[ShoppingCartTotalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cartTotalCell"];
        [cell configureCellContent];
        return cell;
    }
    return nil;
}

#pragma mark - ShoppingCartUpdateDelegate
-(void)shoppingCartHasBeenUpdated:(ShoppingCartManager *)shoppingCartManager {
    [self updateShoppingCartTable];
}

@end
