//
//  NSObject+ObjectCoder.h
//  ObjectCoderTest
//
//  Created by Alex Nichol on 12/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+IvarList.h"
#import "OCPrimitive.h"

@interface NSObject (ObjectCoder)

+ (NSObject *)objectByDecodingObjectCoderRootObject:(NSDictionary *)serialized;
- (NSDictionary *)objectCoderSerialization;

- (id)initWithObjectCoderSerialization:(NSDictionary *)serialized;

@end
