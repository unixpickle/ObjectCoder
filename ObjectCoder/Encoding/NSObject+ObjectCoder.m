//
//  NSObject+ObjectCoder.m
//  ObjectCoderTest
//
//  Created by Alex Nichol on 12/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NSObject+ObjectCoder.h"

#define kObjectEncoded [NSString stringWithUTF8String:@encode(id)]

@implementation NSObject (ObjectCoder)

+ (id)objectByDecodingObjectCoderRootObject:(NSDictionary *)serialized {
	if (!OCTypeEncodingIsObject([serialized objectForKey:@"type"])) {
		return nil;
	}
	NSString * className = [serialized objectForKey:@"class"];
	Class class = NSClassFromString(className);
	if (!class) {
		return nil;
	}
	id object = [[class alloc] initWithObjectCoderSerialization:serialized];
#if !__has_feature(objc_arc)
	return [object autorelease];
#else
	return object;
#endif
}

- (id)initWithObjectCoderSerialization:(NSDictionary *)serialized {
	if ((self = [self init])) {
		NSDictionary * ivarDict = [serialized objectForKey:@"ivars"];
		for (NSString * ivarName in ivarDict) {
			NSDictionary * encodedValue = [ivarDict objectForKey:ivarName];
			if (OCTypeEncodingIsObject([encodedValue objectForKey:@"type"])) {
				// it's a sub-object instance variable
				Class class = NSClassFromString([encodedValue objectForKey:@"class"]);
				if (class) {
					id instance = [[class alloc] initWithObjectCoderSerialization:encodedValue];
					[self setInstanceVariable:ivarName withObject:instance];
				} else {
#if !__has_feature(objc_arc)
					[super dealloc];
#endif
					return nil;
				}
			} else {
				// it's a primitive instance variable
				if (!OCDecodePrimitiveIvar(self, ivarName, encodedValue)) {
#if !__has_feature(objc_arc)
					[super dealloc];
#endif
					return nil;
				}
			}
		}
	}
	return self;
}

- (NSDictionary *)objectCoderSerialization {
	NSMutableDictionary * encodedIvars = [[NSMutableDictionary alloc] init];
	NSArray * ivars = [self instanceVariables];
	for (OCIvarInfo * ivar in ivars) {
		NSDictionary * encoded = nil;
		if (OCIvarIsPrimitive(ivar)) {
			encoded = OCEncodePrimitiveIvar(self, ivar);
		} else {
			if (OCTypeEncodingIsObject(ivar.typeEncoding)) {
				id object = [self getInstanceVariableObject:ivar.name];
				encoded = [object objectCoderSerialization];
			}
		}
		if (encoded) {
			[encodedIvars setObject:encoded forKey:ivar.name];
		}
	}
	return [NSDictionary dictionaryWithObjectsAndKeys:kObjectEncoded, @"type",
													  [self className], @"class",
													  encodedIvars, @"ivars", nil];
}

@end
