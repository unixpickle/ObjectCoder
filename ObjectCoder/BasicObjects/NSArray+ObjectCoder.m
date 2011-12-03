//
//  NSArray+ObjectCoder.m
//  ObjectCoderTest
//
//  Created by Alex Nichol on 12/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NSArray+ObjectCoder.h"

@implementation NSArray (ObjectCoder)

- (NSDictionary *)objectCoderSerialization {
	NSString * className = @"NSArray";
	if ([self isKindOfClass:[NSMutableArray class]]) {
		className = @"NSMutableArray";
	}
	
	NSMutableArray * encodedObjects = [[NSMutableArray alloc] init];
	for (NSObject * object in self) {
		[encodedObjects addObject:[object objectCoderSerialization]];
	}
	
	NSArray * immutable = [NSArray arrayWithArray:encodedObjects];
	
#if !__has_feature(objc_arc)
	[encodedObjects release];
#endif
	
	return OCEncodePrimitive(className, [NSString stringWithUTF8String:@encode(id)], immutable);
}

- (id)initWithObjectCoderSerialization:(NSDictionary *)serialized {
	NSArray * encoded = [serialized objectForKey:@"pvalue"];
	NSMutableArray * decoded = [NSMutableArray array];
	for (NSDictionary * encodedObject in encoded) {
		[decoded addObject:[NSObject objectByDecodingObjectCoderRootObject:encodedObject]];
	}
	self = [self initWithArray:decoded];
	return self;
}

@end
