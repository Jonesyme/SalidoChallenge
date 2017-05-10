//
//  FilterVC.h
//  Salido
//
//  Created by Mike on 5/8/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterVC : UITableViewController
@property (nonatomic, strong) NSString * selectedCatFilter; // filter format: CatID+SubCatID

-(void)selectCategoryFilter:(NSNumber *)catID subCatID:(NSNumber *)subCatID;
-(BOOL)isCategorySelected:(NSNumber *)catID subCatID:(NSNumber *)subCatID;
@end
