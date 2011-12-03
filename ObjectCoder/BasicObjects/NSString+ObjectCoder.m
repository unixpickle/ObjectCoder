//
//  NSString+ObjectCoder.m
//  ObjectCoderTest
//
//  Created by Alex Nichol on 12/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NSString+ObjectCoder.h"

@implementation NSString (ObjectCoder)

- (NSDictionary *)objectCoderSerialization {
	NSString * className = @"NSString";
	if ([self isKindOfClass:[NSMutableString class]]) {
		className = @"NSMutableString";
	}
	return OCEncodePrimitive(className, [NSString stringWithUTF8String:@encode(id)], self);
}

- (id)initWithObjectCoderSerialization:(NSDictionary *)serialized {
	if ((self = [self initWithString:[serialized objectForKey:@"pvalue"]])) {
	}
	return self;
}

@end
