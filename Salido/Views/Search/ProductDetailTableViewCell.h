//
//  ProductDetailTableViewCell.h
//  Salido
//
//  Created by Mike on 5/13/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailTableViewCell : UITableViewCell
// interface outlets
@property (nonatomic, weak) IBOutlet UILabel * nameLabel;
@property (nonatomic, weak) IBOutlet UILabel * valueLabel;
// member functions
-(void)configureCellContent:(NSString *)propertyName propertyValue:(NSString *)propertyValue;
@end
