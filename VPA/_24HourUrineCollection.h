//
//  _24HourUrineCollection.h
//  VPA
//
//  Created by Brandon Koenning on 10/1/15.
//  Copyright © 2015 Brandon Koenning. All rights reserved.
//

#import "TableItem.h"
#import "SerumCreatinine.h"
#import "UrineCreatinine.h"
#import "Volume.h"

@interface _24HourUrineCollection : TableItem


@property (nonatomic) SerumCreatinine *serumCr;
@property (nonatomic) UrineCreatinine *urineCr;
@property (nonatomic) Volume *urineVolume;

@end
