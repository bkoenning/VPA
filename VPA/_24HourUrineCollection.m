//
//  _24HourUrineCollection.m
//  VPA
//
//  Created by Brandon Koenning on 10/1/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "_24HourUrineCollection.h"

@implementation _24HourUrineCollection

-(instancetype)init
{
    self = [super initWithTitle:@"24 Hour Urine Collection"];
    [self setUrineCr:[[UrineCreatinine alloc]initWithFloat:0 andUnits:MILLIGRAMS_PER_DECILITER]];
    [self setSerumCr:[[SerumCreatinine alloc]initWithFloat:0 andUnits:MG_PER_DECILITER]];
    [self setUrineVolume:[[Volume alloc]initWithFloat:0 andUnits:L]];
    [self setIsSet:NO];
    return  self;
}

-(NSString*)tableDescription
{
    NSMutableString *string = [NSMutableString stringWithString:@"Data entered:\n"];
    [string appendString:@"Serum creatinine:  "];
    if (![self serumCr]){
        [string appendString:@"null"];
    }
    [string appendString:[[self serumCr]description]];
    [string appendString:@"\nUrine creatinine:  "];
    [string appendString:[[self urineCr]description]];
    [string appendString:@"\nUrine Volume:  "];
    [string appendString:[[self urineVolume]description]];
    return [NSString stringWithString:string];
}

@end
