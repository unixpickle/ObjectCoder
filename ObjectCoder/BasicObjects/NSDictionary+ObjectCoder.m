//
//  NSDictionary+ObjectCoder.m
//  ObjectCoderTest
//
//  Created by Alex Nichol on 12/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NSDictionary+ObjectCoder.h"

@implementation NSDictionary (ObjectCoder)

// Note that dictionaries are encoded as arrays, containing the pattern
// key, object, key, object, etc. This is because some dictionary archive
// formats do not support associative arrays with keys that are not strings.

- (NSDictionary *)objectCoderSerialization {
	NSString * className = @"NSDictionary";
	if ([self isKindOfClass:[NSDictionary class]]) {
		className = @"NSMutableDictionary";
	}
	NSString * typeEncoding = [NSString stringWithUTF8String:@encode(id)];
	NSMutableArray * encoded = [NSMutableArray array];
	for (NSObject * key in self) {
		NSObject * object = [self objectForKey:key];
		[encoded addObject:[key objectCoderSerialization]];
		[encoded addObject:[object objectCoderSerialization]];
	}
	return OCEncodePrimitive(className, typeEncoding, encoded);
}

- (id)initWithObjectCoderSerialization:(NSDictionary *)serialized {
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	NSArray * encoded = [serialized objectForKey:@"pvalue"];
	for (NSUInteger i = 0; i < [encoded count] - 1; i += 2) {
		NSObject * key = [NSObject objectByDecodingObjectCoderRootObject:[encoded objectAtIndex:i]];
		NSObject * value = [NSObject objectByDecodingObjectCoderRootObject:[encoded objectAtIndex:i + 1]];
		[dictionary setObject:value forKey:key];
	}
	self = [self initWithDictionary:dictionary];
	return self;
}

@end
