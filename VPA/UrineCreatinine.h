//
//  SerumCreatinine.h
//  VP
//
//  Created by Brandon Koenning on 8/14/15.
//  Copyright (c) 2015 Brandon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NumberValue.h"



typedef enum
{
    MILLIGRAMS_PER_DECILITER,
    MICRO_MOLES_PER_LITER
    
}UrineCreatinineConcentrationUnit;

@interface UrineCreatinine : NSObject <NumberValue>

@property (nonatomic) NSNumber *value;
@property (nonatomic) UrineCreatinineConcentrationUnit units;

-(instancetype) initWithFloat: (float)val andUnits: (UrineCreatinineConcentrationUnit) un;
-(void)convertTo: (UrineCreatinineConcentrationUnit) un;


@end
