//
//  NSDictionary+ObjectCoder.h
//  ObjectCoderTest
//
//  Created by Alex Nichol on 12/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+ObjectCoder.h"

@interface NSDictionary (ObjectCoder)

- (NSDictionary *)objectCoderSerialization;
- (id)initWithObjectCoderSerialization:(NSDictionary *)serialized;

@end
