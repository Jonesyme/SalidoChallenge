//
//  Category.h
//  Salido
//
//  Created by Mike on 5/7/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ResponseStatus;

/**
 Wine.com - SubCategory JSON Mapping (i.e. vintage years: 1998,1999,2000,...),
 */
@interface SubCategory : NSObject
    @property (nonatomic,strong) NSNumber * Id;
    @property (nonatomic,strong) NSString * Name;
    //@property (nonatomic,strong) NSString * Description;
    //@property (nonatomic,strong) NSString * Url;
@end


/**
 Wine.com - Category JSON Mapping (i.e. vintage)
 */
@interface Category : NSObject
    @property (nonatomic,strong) NSNumber * Id;
    @property (nonatomic,strong) NSString * Name;
    //@property (nonatomic,strong) NSString * Description;
    @property (nonatomic,strong) NSArray  * Refinements;
@end


/**
 Wine.com - CategoryResponse JSON Mapping
 */
@interface CategoryResponseObject : NSObject
    @property (nonatomic,strong) ResponseStatus * Status;
    @property (nonatomic,strong) NSArray        * Categories;
@end
