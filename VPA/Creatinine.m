//
//  Creatinine.m
//  VPA
//
//  Created by Brandon Koenning on 10/19/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "Creatinine.h"

@implementation Creatinine

-(instancetype)initWithFloat:(float)amt massUnit:(MassUnit)un
{
    self = [super initWithFloat:amt massUnit:un molecularWeight:113.1179];
    return self;
}

-(instancetype)init
{
    self = [self initWithFloat:0 massUnit:MG];
    return  self;
}

@end
