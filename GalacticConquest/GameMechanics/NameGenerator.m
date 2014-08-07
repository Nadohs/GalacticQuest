//
//  NameGenerator.m
//  GalacticConquest
//
//  Created by Rich on 3/14/14.
//  Copyright (c) 2014 NadohsInc. All rights reserved.
//

#import "NameGenerator.h"

@implementation NameGenerator

+(NSArray*)consonentArray{
    NSArray *consonents = @[@"b",@"c",@"d",@"f",@"g",@"h",@"j",@"k",@"l",@"m",@"n",@"p",@"q",@"r",@"s",@"t",@"v",@"w",@"x",@"z"];
    return  consonents;
}

+(NSArray*)vowelArray{
    NSArray*vowels = @[@"a",@"e",@"i",@"o",@"u",@"y"];
    return vowels;
}

+(NSString*)rand:(NSArray*)someList{
    uint32_t rnd = arc4random_uniform([someList count]);
    return [someList objectAtIndex:rnd];
}

+(NSString*)getRandomOre{
    
    // C V C V V
    // V C V C V
    // C V C V V C V
    // C V C V C V

    NSArray*v = [self vowelArray];
    NSArray *c = [self consonentArray];
    NSString *retString;
    int randType = arc4random()%4;
    switch (randType) {
        case 0:
            retString = [NSString stringWithFormat:@"%@%@%@%@%@",[self rand:c],[self rand:v ],[self rand:c ],
                                                            [self rand:v ],[self rand:v ]];
            break;
        case 1:
            retString = [NSString stringWithFormat:@"%@%@%@%@%@",[self rand:v],[self rand:c ],[self rand:v ],
                                                            [self rand:c ],[self rand:v ]];
            break;
        case 2:
            retString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",[self rand:c],[self rand:v ],[self rand:c ],
                                                               [self rand:v ],[self rand:v ],[self rand:c ],[self rand:v ]];
            break;
        case 3:
            retString = [NSString stringWithFormat:@"%@%@%@%@%@%@",[self rand:c],[self rand:v ],[self rand:c ],
                                                             [self rand:v ],[self rand:c ],[self rand:v ]];
            break;
        default:
            break;
    }
    
    BOOL ending = arc4random()%2;
    if (ending) {
        retString = [retString stringByAppendingString:@"mite"];
    }
    else{
        retString = [retString stringByAppendingString:@"nite"];
    }
    
    return retString;
}


+(NSArray*)getRandomNameListQuantity:(int)num{
    NSMutableArray *retList = [[NSMutableArray alloc]initWithCapacity:num];
    
    int i =0;

    while (i<num) {
        [retList addObject:self.getRandomOre];
        i++;
    }
    return (NSArray*)retList;
}


@end
