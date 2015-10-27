//
//  CreatinineConcentration.m
//  VPA
//
//  Created by Brandon Koenning on 10/27/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "CreatinineConcentration.h"

@implementation CreatinineConcentration

-(instancetype)initWithCreatinineAmount:(Creatinine *)cr andVolume:(Volume *)v
{
    self = [super initWithMolecularAmount:cr andVolume:v];
    return  self;
}

@end
