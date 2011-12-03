//
//  NSData+ObjectCoder.m
//  ObjectCoderTest
//
//  Created by Alex Nichol on 12/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NSData+ObjectCoder.h"

@implementation NSData (ObjectCoder)

- (NSDictionary *)objectCoderSerialization {
	NSString * className = @"NSData";
	if ([self isKindOfClass:[NSMutableData class]]) {
		className = @"NSMutableData";
	}
	
	return OCEncodePrimitive(className, [NSString stringWithUTF8String:@encode(id)], self);
}

- (id)initWithObjectCoderSerialization:(NSDictionary *)serialized {
	if ((self = [self initWithData:[serialized objectForKey:@"pvalue"]])) {
	}
	return self;
}

@end
