//
//  ShoppingCartVC.m
//  Salido
//
//  Created by Mike on 5/8/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import "ShoppingCartVC.h"

@interface ShoppingCartVC ()

@end

@implementation ShoppingCartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


@end
