//
//  Concentration.m
//  VPA
//
//  Created by Brandon Koenning on 10/26/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "Concentration.h"

@implementation Concentration

@synthesize mol,vol;

-(instancetype)initWithMolecularAmount:(Molecule *)m andVolume:(Volume *)v
{
    self = [super init];
    [self setMol:m];
    [self setVol:v];
    return  self;
}

-(void)reduce
{
    [[self mol]setMolarAmount:[NSNumber numberWithFloat:[[[self mol]molarAmount]floatValue] / [[[self vol]volume]floatValue]]];

    [[self mol]setMassAmount:[NSNumber numberWithFloat:[[[self mol]massAmount]floatValue] / [[[self vol]volume]floatValue]]];
    [[self vol]setVolume:[NSNumber numberWithFloat:1.0]];
}

-(Molecule*)getAmountPerVolume:(Volume*)v
{
    [v convertTo:[[self vol]unit]];
    [self reduce];
    return [[Molecule alloc]initWithMassFloat:[[[self mol]massAmount]floatValue] * [[v volume]floatValue] massUnit:[[self mol]massunit] molecularWeight:[[self mol]molecularWeight]];
}

-(Volume*)getVolumePerMolecule:(Molecule*)m
{
    [m convertToMassUnit:[[self mol]massunit]];
    [self reduce];
    return [[Volume alloc]initWithFloat: (1.0 / [[[self mol]massAmount]floatValue]) * [[m massAmount]floatValue] andUnits:[[self vol]unit]];
}
@end
