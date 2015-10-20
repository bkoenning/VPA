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
    MG,
    MMOL,
    G,
    MICROMOL,
    MOL
}MassUnit;

@interface Molecule : NSObject <NumberValue>

@property (nonatomic) NSNumber* amount;
@property (nonatomic) MassUnit unit;
@property (nonatomic) float molecularWeight;


-(instancetype)initWithFloat: (float)amt massUnit:(MassUnit)un molecularWeight:(float)mw;
-(float)getValueIn: (MassUnit)mu;


@end
