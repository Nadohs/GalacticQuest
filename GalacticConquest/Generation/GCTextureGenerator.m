//
//  GCTextureGenerator.m
//  GalacticConquest
//
//  Created by Rich on 11/13/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import "GCTextureGenerator.h"

@implementation GCTextureGenerator


+(CGImageRef) generateNoiseImageSized:(CGSize )size factor:(CGFloat)factor type:(filterType)type{
    //CF_RETURNS_RETAINED {
    NSUInteger bits = fabs(size.width) * fabs(size.height);//*3;
    char *rgba = (char *)malloc(bits);
    srand(124);
    
    switch (type) {
        case filterTypeNormal:
            [self filterTypeMountainous:rgba factor:factor bits:bits];
            break;
        case filterTypeMoutain:
            [self filterTypeMountainous:rgba factor:factor bits:bits];
            break;
        case filterTypeSwirls:
            [self filterTypeMountainous:rgba factor:factor bits:bits];
            break;
        default:
            [self filterTypeMountainous:rgba factor:factor bits:bits];
            break;
    }

    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapContext = CGBitmapContextCreate(rgba, fabs(size.width), fabs(size.height),
                                                       8, fabs(size.width), colorSpace, kCGImageAlphaNone);
    CGImageRef image = CGBitmapContextCreateImage(bitmapContext);
    
    CFRelease(bitmapContext);
    CGColorSpaceRelease(colorSpace);
    free(rgba);
    
    return [self roundedCornersWithImageRef:image   ];
}


+(void)filterTypeMountainous:(char *)rgba factor:(CGFloat)factor bits:(NSInteger)bits{
    srand(124);
    
    rgba[0] = (rand() % 256) * factor;;
    
    for(int i = 1; i < bits; ++i){
        int pixel = (rand() % 256) * factor;
        if ((int)rgba[i-1] < 128 && pixel > 128) {
            pixel = (int)rgba[i-1] - 128/8;
        }else{
            
        }
        rgba[i] = pixel;
    }
    
}

+(void)filterTypeNormal:(char *)rgba factor:(CGFloat)factor bits:(NSInteger)bits{
    srand(124);
    
    rgba[0] = (rand() % 256) * factor;;
    
    for(int i = 1; i < bits; ++i){
        int pixel = (rand() % 256) * factor;
        if ((int)rgba[i-1] < 128 && pixel > 128) {
            pixel = (int)rgba[i-1] - 128/8;
        }else{
            
        }
        rgba[i] = pixel;
    }
    
}





//SHOWS UP BLACK
+(CGImageRef) generateColorNoiseImageSized:(CGSize )size factor:(CGFloat)factor type:(filterType)type{
//    return [self generateNoiseImageSized:(CGSize )size factor:(CGFloat)factor type:(filterType)type];
    //CF_RETURNS_RETAINED {
    NSUInteger bits = fabs(size.width) * fabs(size.height * 4);//*3;
    char *rgba = (char *)malloc(bits);
    srand(124);
    
    
    switch (type) {
        case filterTypeNormal:
            [self filterTypeNormal:rgba factor:factor bits:bits];
            break;
        case filterTypeMoutain:
            [self filterTypeMountainous:rgba factor:factor bits:bits];
            break;
        case filterTypeSwirls:
            [self filterTypeMountainous:rgba factor:factor bits:bits];
            break;
        default:
            [self filterTypeMountainous:rgba factor:factor bits:bits];
            break;
    }
    
    
    //    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //    CGContextRef bitmapContext = CGBitmapContextCreate(rgba, fabs(size.width), fabs(size.height),
    //                                                       8, fabs(size.width), colorSpace, kCGImageAlphaNone);
    //    CGImageRef image = CGBitmapContextCreateImage(bitmapContext);
    
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL,
                                                              rgba,
                                                              size.width * size.height*4,
                                                              NULL);
    
    int bitsPerComponent =  8;
//    int bitsPerPixel     = 32;
//    int bytesPerRow      = 4 * size.width;
    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceGray();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrder32Big;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    CGImageRef imageRef = CGImageCreate(size.width,
                                        size.height,
                                        8,
                                        32,
                                        4*size.width,colorSpaceRef,
                                        bitmapInfo,
                                        provider,NULL,NO,renderingIntent);
    
//    CFRelease(renderingIntent);
    CGColorSpaceRelease(colorSpaceRef);
    free(rgba);
    
    return [self roundedCornersWithImageRef:imageRef];
}



+(CGImageRef)roundedCornersWithImageRef:(CGImageRef)imageRef{
    // Get your image somehow
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    
    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContextWithOptions(imageView.frame.size, NO, [UIScreen mainScreen].scale);
    
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:imageView.frame
                                cornerRadius:150.0] addClip];
    // Draw your image
    [image drawInRect:imageView.bounds];
    
    // Get the image, here setting the UIImageView image
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    
    return imageView.image.CGImage;
}


@end
