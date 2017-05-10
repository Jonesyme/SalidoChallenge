//
//  UIImage+DownloadImg.h
//  Salido
//
//  Created by Mike on 5/10/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (DownloadImg)

+ (void)downloadFromURL:(NSURL*)url callback:(void (^)(UIImage *image))callback;

@end
