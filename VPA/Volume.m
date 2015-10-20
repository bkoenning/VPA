//
//  Volume.m
//  VPA
//
//  Created by Brandon Koenning on 10/15/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "Volume.h"

@implementation Volume

@synthesize volume, unit;

-(instancetype)initWithFloat:(float)vol andUnits:(VolumeUnit)un
{
    self =  [super init];
    [self setVolume:[NSNumber numberWithFloat:vol]];
    [self setUnit:un];
    return  self;
}

-(NSString*)unitString
{
    if ([self unit] == ML) return @"mL";
    else return @"L";
}


-(void)convertTo:(VolumeUnit)vu
{
    if (vu == L && [self unit] == ML){
        [self setVolume:[NSNumber numberWithFloat:[[self volume]floatValue] / 1000]];
        [self setUnit:vu];
    }
    else if (vu == ML && [self unit] == L){
        [self setVolume:[NSNumber numberWithFloat:[[self volume]floatValue] * 1000]];
        [self setUnit:vu];
    }
}

-(Volume*)getVolumeAs:(VolumeUnit)vu
{
    if (vu == L && [self unit] ==ML){
        return [[Volume alloc]initWithFloat:[[self volume]floatValue]/1000 andUnits:vu];
    }
    else if (vu ==ML && [self unit] == L){
        return [[Volume alloc]initWithFloat:[[self volume]floatValue] * 1000 andUnits:vu];
    }
    else return [[Volume alloc]initWithFloat:[[self volume]floatValue] andUnits:[self unit]];
}
-(NSString*) valueAsString
{
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    [format setMaximumFractionDigits:2];
    return [NSString stringWithFormat:@"%@", [ format stringFromNumber:[self volume]]];
}

-(NSNumber*) getValueAs:(VolumeUnit)vu
{
    if (vu == L && [self unit] == ML){
        return  [NSNumber numberWithFloat:[[self volume]floatValue] / 1000];
    }
    else if (vu == ML && [self unit ] == L){
        return [NSNumber numberWithFloat:[[self volume] floatValue ] * 1000];
    }
    else
        return [self volume];
}

-(NSString*)description
{
    return [NSString stringWithFormat:@"%@%@", [self valueAsString], [self unitString]];
}

@end
