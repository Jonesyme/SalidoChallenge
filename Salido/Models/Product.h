//
//  Product.h
//  Salido
//
//  Created by Mike on 5/8/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONJoy.h"

@class ProductResponseObject;
@class Product;
@class ResponseStatus;

/**
 Wine.com - SearchResponseObject (i.e. Product Searches)
 */
@interface SearchResponseObject : NSObject
@property (nonatomic,strong) ResponseStatus * Status;
@property (nonatomic,strong) ProductResponseObject * Products;
@end

/**
 Wine.com - ProductResponseObject
 */
@interface ProductResponseObject : NSObject
@property (nonatomic,strong) NSArray<Product *> * List;
@property (nonatomic,strong) NSNumber * Offset;
@property (nonatomic,strong) NSNumber * Total;
@property (nonatomic,strong) NSString * Url;
@end

/**
 Wine.com - ProductLabel JSON Mapping
 */
@interface ProductLabel : NSObject
@property (nonatomic,strong) NSString * Id;
@property (nonatomic,strong) NSString * Name;
@property (nonatomic,strong) NSString * Url;
@end
/**
 Wine.com - ProductAttribute JSON Mapping
 */
@interface ProductAttribute : NSObject
@property (nonatomic,strong) NSNumber * Id;
@property (nonatomic,strong) NSString * Name;
@property (nonatomic,strong) NSString * Url;
@property (nonatomic,strong) NSString * ImageUrl;
@end
/**
 Wine.com - ProductRating JSON Mapping
 */
@interface ProductRating : NSObject
@property (nonatomic,strong) NSNumber * HighestScore;
@property (nonatomic,strong) NSArray * List;
@end


/**
 Wine.com - Product JSON Mapping
 */
@interface Product : NSObject
@property (nonatomic,strong) NSNumber * Id;
@property (nonatomic,strong) NSString * Name;
@property (nonatomic,strong) NSString * Url;
@property (nonatomic,strong) NSArray<ProductLabel *> * Labels;
@property (nonatomic,strong) NSString * Type;
@property (nonatomic,strong) NSString * Vintage;
@property (nonatomic,strong) NSString * Description;
@property (nonatomic,strong) NSNumber * PriceMax;
@property (nonatomic,strong) NSNumber * PriceMin;
@property (nonatomic,strong) NSNumber * PriceRetail;
@property (nonatomic,strong) NSArray<ProductAttribute *> * ProductAttributes;
@property (nonatomic,strong) ProductRating * Ratings;
/*
@property (nonatomic,strong) NSDictionary * Appellation;
@property (nonatomic,strong) NSDictionary * Varietal;
@property (nonatomic,strong) NSDictionary * Vineyard;
@property (nonatomic,strong) NSDictionary * Community;
@property (nonatomic,strong) NSDictionary * GeoLocation;
*/

-(NSString *)getPriceCurrencyString;

@end
