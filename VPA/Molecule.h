//
//  Molecule.h
//  VPA
//
//  Created by Brandon Koenning on 10/19/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NumberValue.h"

typedef enum
{
    G = 1,
    MILLIGRAM = 1000,
    MICROGRAM = 1000000
}MassUnit;

typedef enum
{
    MOL = 1,
    MILLIMOL = 1000,
    MICROMOL = 1000000
}MolarUnit;


@interface Molecule : NSObject <NumberValue>

@property (nonatomic) NSNumber* molarAmount;
@property (nonatomic) NSNumber* massAmount;
@property (nonatomic) MassUnit massunit;
@property (nonatomic) MolarUnit molarunit;
@property (nonatomic) float molecularWeight;
@property (nonatomic) BOOL returnAsMolar;


-(instancetype)initWithMolarFloat: (float)amt molarUnit:(MolarUnit)un molecularWeight:(float)mw;
-(instancetype)initWithMassFloat:  (float)amt massUnit:(MassUnit)un molecularWeight:(float)mw;
-(float)getValueInMass:(MassUnit)mu;
-(float)getValueInMolar:(MolarUnit)mu;
-(void)convertToMassUnit:(MassUnit)mu;
-(void)convertToMolarUnit:(MolarUnit)mu;


@end
