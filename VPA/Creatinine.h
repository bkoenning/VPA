//
//  Creatinine.h
//  VPA
//
//  Created by Brandon Koenning on 10/19/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Molecule.h"


@interface Creatinine : Molecule

-(instancetype)initWithFloat:(float)amt massUnit:(MassUnit)un;

@end
