//
//  WineWebService.h
//  Salido
//
//  Created by Mike on 5/10/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseWebService.h"
#import "Category.h"
#import "Product.h"

/**
 Wine.com Public WebService API Wrapper and Search Filter Store
 */
@interface WineWebService : BaseWebService {
    NSString * _wineHostURL;
    NSString * _wineAPIKey;
}

// cache categories on first download since they will never change
@property (nonatomic,strong) CategoryResponseObject * categoryCache;

/**
 singleton instance 
 */
+(id)sharedInstance;

/**
 Fetch all categories from Wine.com API
 note: categories can be fetched once and cached for the remainder of the session
 */
-(void)fetchAllCategories:(void (^)(CategoryResponseObject *, NSError *))completion;

/**
 Search for products via Wine.com API
 @param categoryFilter dictionary of selected category filters
 @param searchStr raw query string
 */
-(void)searchForProductsWithFilter:(NSString *)categoryFilter searchString:(NSString *)searchStr completion:(void (^)(SearchResponseObject *, NSError *))completion;

@end
