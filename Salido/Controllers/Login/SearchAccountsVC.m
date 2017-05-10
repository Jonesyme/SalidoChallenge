//
//  SearchAccountsVC.m
//  Salido
//
//  Created by Mike on 5/7/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import "SearchAccountsVC.h"
#import "EmployeeTableViewCell.h"
#import "EmployeeTableViewCellDeletionProtocol.h"
#import "Employee.h"
#import "AccountManager.h"

@interface SearchAccountsVC () <EmployeeTableViewCellDeletionDelegate>
@end

@implementation SearchAccountsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadAccountTable];
}
-(void)reloadAccountTable {
    _employeeList = [[AccountManager sharedInstance] searchEmployeeList:_searchBar.text];
    [_tableView reloadData];
}
-(void)executeAccountSearch:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    _employeeList = [[AccountManager sharedInstance] searchEmployeeList:searchBar.text];
    [_tableView reloadData];
}

#
#pragma mark - UITableViewDelegate
#
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_employeeList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EmployeeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EmployeeCell" forIndexPath:indexPath];
    if(cell==nil)
        cell = [[EmployeeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EmployeeCell"];
    cell.employee = [_employeeList objectAtIndex:indexPath.row];
    [cell configureCellContent];
    cell.delegate = self; // delete employee record callback delegate
    return cell;
}

#
#pragma mark - UISearchBarDelegate
#
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self executeAccountSearch:searchBar];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self executeAccountSearch:searchBar];
}
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar {
    [self executeAccountSearch:searchBar];
}

#pragma mark - EmployeeTableViewCellDelegate
- (void)deleteEmployeeRecordWithPIN:(NSString *)pin {
    [[AccountManager sharedInstance] deleteEmployeeWithPIN:pin];
    [self reloadAccountTable];
}


@end
