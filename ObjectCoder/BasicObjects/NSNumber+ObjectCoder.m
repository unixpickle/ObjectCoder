//
//  NSNumber+ObjectCoder.m
//  ObjectCoderTest
//
//  Created by Alex Nichol on 12/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NSNumber+ObjectCoder.h"

@implementation NSNumber (ObjectCoder)

- (NSDictionary *)objectCoderSerialization {
	return [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithUTF8String:@encode(id)], @"type",
			@"NSNumber", @"class", self, @"pvalue", nil];
}

- (id)initWithObjectCoderSerialization:(NSDictionary *)serialized {
	NSNumber * oldNumber = [serialized objectForKey:@"pvalue"];
#if !__has_feature(objc_arc)
	[super dealloc];
#endif
	self = [oldNumber copy];
	return self;
}

@end
