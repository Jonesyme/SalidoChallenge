//
//  NSNumber+CurrencyString.m
//  Salido
//
//  Created by Mike on 5/12/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import "NSNumber+CurrencyString.h"

@implementation NSNumber (NSNumber_CurrencyString)

-(NSString *)currencyFormattedString {
    if(self==nil)
        return @"$0.00";
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    return [formatter stringFromNumber:self];
}
@end
