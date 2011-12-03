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
	return [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithUTF8String:@encode(id)], @"type",
													  className, @"class", self, @"pvalue", nil];
}

- (id)initWithObjectCoderSerialization:(NSDictionary *)serialized {
	if ((self = [self initWithString:[serialized objectForKey:@"pvalue"]])) {
	}
	return self;
}

@end
