//
//  SearchAccountsVC.h
//  Salido
//
//  Created by Mike on 5/7/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchAccountsVC : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (nonatomic,strong) IBOutlet UITableView * tableView;
@property (nonatomic,weak) IBOutlet UISearchBar * searchBar;
@property (nonatomic,strong) NSArray * employeeList;

/**
 Helper invoked by multiple UISearchBar delegate methods
 */
-(void)executeAccountSearch:(UISearchBar *)searchBar;

@end
