//
//  Molecule.m
//  VPA
//
//  Created by Brandon Koenning on 10/19/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "Molecule.h"


@implementation Molecule

@synthesize molecularWeight, amount, unit;


-(instancetype)initWithFloat:(float)amt massUnit:(MassUnit)un molecularWeight:(float)mw
{
    self = [super init];
    [self setMolecularWeight:mw];
    [self setUnit:un];
    [self setAmount:[NSNumber numberWithFloat:amt]];
    return  self;
}

-(instancetype)init
{
    self = [self initWithFloat:0 massUnit:MG molecularWeight:0];
    return  self;
}

-(NSString*)valueAsString
{
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    [format setMaximumFractionDigits:4];
    return [NSString stringWithFormat:@"%@", [ format stringFromNumber:[self amount]]];
}

-(NSString*)unitString
{
    if ([self unit] == MG){
        return @"mg";
    }
    else
        return @"mmol";
}

-(NSString*)description
{
    return [NSString stringWithFormat:@"%@ %@",[self valueAsString], [self unitString]];
}
-(float)getValueIn:(MassUnit)mu
{
    if (mu == [self unit]){
        return [[self amount]floatValue];
    }
    else if (mu == MOL && [self unit] == MMOL){
        return [[self amount]floatValue] / 1000;
    }
    else if (mu == MOL && [self unit] == MICROMOL){
        return  [[self amount]floatValue] / 1000000;
    }
    else if (mu == MMOL && [self unit] == MOL){
        return [[self amount]floatValue] * 1000;
    }
    else if (mu == MMOL && [self unit] == MICROMOL){
        return  [[self amount]floatValue] / 1000;
    }
    else if (mu == MICROMOL && [self unit] == MMOL){
        return [[self amount]floatValue] * 1000;
    }
    else if (mu == MICROMOL && [self unit] == MOL){
        return [[self amount] floatValue] * 1000000;
    }
    else if (mu == MG && [self unit] == G){
        return  [[self amount] floatValue] * 1000;
    }
    else if (mu == G && [self unit] == MG){
        return  [[self amount]floatValue] / 1000;
    }
    else if ((mu == MMOL && [self unit] == MG) || (mu == MOL && [self unit] == G)){
        return [[self amount]floatValue] / [self molecularWeight];
    }
    else if ((mu == MG && [self unit] == MMOL) || (mu == G && [self unit] == MOL)){
        return [[self amount]floatValue] * [self molecularWeight];
    }
    else if (mu == MG && [self unit] == MOL){
        return  [self getValueIn:MMOL] * [self molecularWeight];
    }
    else if (mu == MG && [self unit] == MICROMOL){
        return  [self getValueIn:MICROMOL] * [self molecularWeight];
    }
    else if (mu == G && [self unit] == MICROMOL){
        return [self getValueIn:MOL] * [self molecularWeight];
    }
    else if (mu == G && [self unit] == MMOL){
        return [self getValueIn:MOL] * [self molecularWeight];
    }
    else if (mu == MMOL && [self unit] == G){
        return  [self getValueIn:MG] * [self molecularWeight];
    }
    
}




@end
