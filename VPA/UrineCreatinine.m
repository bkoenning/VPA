//
//  SerumCreatinine.m
//  VP
//
//  Created by Brandon Koenning on 8/14/15.
//  Copyright (c) 2015 Brandon. All rights reserved.
//

#import "UrineCreatinine.h"

const float MICROMOL_PER_LITER_PER_MILLIGRAMS_PER_DECILITER = 88.4;

@implementation UrineCreatinine

@synthesize  value, units;

-(instancetype)initWithFloat:(float)val andUnits:(UrineCreatinineConcentrationUnit)un
{
    self = [super init];
    [self setValue:[NSNumber numberWithFloat: val]];
    [self setUnits:un];
    return  self;
}

-(instancetype) init
{
    self = [self initWithFloat:0 andUnits:MILLIGRAMS_PER_DECILITER];
    return self;
}


-(NSString*)valueAsString
{
    NSNumberFormatter *format = [[NSNumberFormatter alloc]init];
    [format setMaximumFractionDigits:2];
    return  [NSString stringWithFormat:@"%@",[format stringFromNumber:[self value]]];
}

-(NSString*)unitString
{
    if ([self units] == MILLIGRAMS_PER_DECILITER){
        return [NSString stringWithFormat:@"%@", @"mg/dL"];
    }
    else{
        return [NSString stringWithFormat:@"%@",@"\u00B5mol/dL"];
    }
}

-(NSString*) description
{
    return [NSString stringWithFormat:@"%@ %@", [self valueAsString], [self unitString]];
}

-(void)convertTo:(UrineCreatinineConcentrationUnit)un
{
    if (un == MILLIGRAMS_PER_DECILITER && [self units] == MICRO_MOLES_PER_LITER){
        [self setValue:[NSNumber numberWithFloat:[[self value]floatValue] / MICROMOL_PER_LITER_PER_MILLIGRAMS_PER_DECILITER]];
        [self setUnits:un];
    }
    else if (un == MICRO_MOLES_PER_LITER && [self units] == MILLIGRAMS_PER_DECILITER){
        [self setValue:[NSNumber numberWithFloat:[[self value]floatValue] * MICROMOL_PER_LITER_PER_MILLIGRAMS_PER_DECILITER]];
        [self setUnits:un];
    }
}
@end
