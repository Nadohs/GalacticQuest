//
//  GCTextureGenerator.h
//  GalacticConquest
//
//  Created by Rich on 11/13/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    filterTypeNormal,
    filterTypeMoutain,
    filterTypeSwirls,
} filterType;


@interface GCTextureGenerator : NSObject

+(CGImageRef) generateNoiseImageSized:(CGSize )size factor:(CGFloat)factor type:(filterType)type;
+(CGImageRef) generateColorNoiseImageSized:(CGSize )size factor:(CGFloat)factor type:(filterType)type;
@end
