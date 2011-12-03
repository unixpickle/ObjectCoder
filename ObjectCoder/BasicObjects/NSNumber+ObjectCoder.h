//
//  NSNumber+ObjectCoder.h
//  ObjectCoderTest
//
//  Created by Alex Nichol on 12/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCPrimitive.h"

@interface NSNumber (ObjectCoder)

- (NSDictionary *)objectCoderSerialization;
- (id)initWithObjectCoderSerialization:(NSDictionary *)serialized;

@end
