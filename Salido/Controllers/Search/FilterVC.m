//
//  FilterVC.m
//  Salido
//
//  Created by Mike on 5/8/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import "FilterVC.h"
#import "WineWebService.h"
#import "FilterTableViewCell.h"
#import "Category.h"
#import "SearchVC.h"
#import "SWRevealViewController.h"

@interface FilterVC ()

@property (nonatomic, strong) NSMutableArray<Category *> * categoryList;
-(void)fetchCategoryList;
-(void)reloadCategoryTable;
@end


@implementation FilterVC

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        _categoryList = nil;
        _selectedCatFilter = nil;
        [self fetchCategoryList];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadCategoryTable];
}

/**
 fetch category list from Wine.com's remote API if its not already cached
 */
-(void)fetchCategoryList {
    [[WineWebService sharedInstance] fetchAllCategories:^(CategoryResponseObject *response, NSError *error) {
        _categoryList = [[NSMutableArray alloc] init];
        for(Category * category in response.Categories)
            [_categoryList addObject:category];
        [self reloadCategoryTable];
    }];
}

-(void)reloadCategoryTable {
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_categoryList count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Category * topCategory = [_categoryList objectAtIndex:section];
    return [topCategory.Refinements count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    Category * topCategory = [_categoryList objectAtIndex:section];
    return topCategory.Name;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FilterTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"filterCell" forIndexPath:indexPath];
    if(cell==nil)
        cell = [[FilterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"filterCell"];
    
    Category * topCategory = [_categoryList objectAtIndex:indexPath.section];
    SubCategory * subCategory = [topCategory.Refinements objectAtIndex:indexPath.row];
    if([self isCategorySelected:topCategory.Id subCatID:subCategory.Id]) {
        [cell.textLabel setTextColor:[UIColor blueColor]];
    } else {
        [cell.textLabel setTextColor:[UIColor whiteColor]];
    }
    cell.subCategory = subCategory;
    [cell configureCellContent];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FilterTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:false];
    
    Category * topCategory = [_categoryList objectAtIndex:indexPath.section];
    SubCategory * subCategory = [topCategory.Refinements objectAtIndex:indexPath.row];
    if([self isCategorySelected:topCategory.Id subCatID:subCategory.Id]) {
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        [self selectCategoryFilter:nil subCatID:nil]; // special case where we're really "deselecting" the current one
    } else {
        [cell.textLabel setTextColor:[UIColor blueColor]];
        [self selectCategoryFilter:topCategory.Id subCatID:subCategory.Id];
    }
}

-(void)selectCategoryFilter:(NSNumber *)catID subCatID:(NSNumber *)subCatID {
    if(catID==nil) {
        _selectedCatFilter = nil;
    } else {
        _selectedCatFilter = [NSString stringWithFormat:@"%@+%@", catID, subCatID];
    }
    [self reloadCategoryTable];
    // inform SearchVC to re-process search query
    SearchVC * searchVC = (SearchVC *)self.revealViewController.frontViewController;
    [searchVC setSelectedCategoryFilter:_selectedCatFilter];
    [searchVC executeSearchQuery];
    [searchVC toolbarToggleFiltersBtnTapped:searchVC]; // close category side-menu
}
-(BOOL)isCategorySelected:(NSNumber *)catID subCatID:(NSNumber *)subCatID {
    NSString * filterStr = [NSString stringWithFormat:@"%@+%@", catID, subCatID];
    if([filterStr isEqualToString:_selectedCatFilter])
        return true;
    return false;
}


@end
