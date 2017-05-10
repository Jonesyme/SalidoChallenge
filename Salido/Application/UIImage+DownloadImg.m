//
//  UIImage+DownloadImg.m
//  Salido
//
//  Created by Mike on 5/10/17.
//  Copyright © 2017 Michael Jones. All rights reserved.
//

#import "UIImage+DownloadImg.h"

@implementation UIImage (DownloadImg)

+(void)downloadFromURL:(NSURL*)url callback:(void (^)(UIImage *image))callback {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSData * imageData = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:imageData];
            callback(image);
        });
    });
}

@end
