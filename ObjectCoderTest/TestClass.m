//
//  TestClass.m
//  ObjectCoderTest
//
//  Created by Alex Nichol on 12/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TestClass.h"

@implementation TestClass

- (id)initWithNumber:(int)aNumber message:(NSString *)aMessage dictionary:(NSDictionary *)aDictionary array:(NSArray *)anArray {
	if ((self = [super init])) {
		number = aNumber;
#if __has_feature(objc_arc)
		message = aMessage;
		dictionary = aDictionary;
		array = anArray;
#else
		message = [aMessage retain];
		dictionary = [aDictionary retain];
		array = [anArray retain];
#endif
	}
	return self;
}

- (void)printInfo {
	NSLog(@"%d ... %@", number, message);
	NSLog(@"%@", dictionary);
	NSLog(@"%@", array);
}

#if !__has_feature(objc_arc)

- (void)dealloc {
	[message release];
	[dictionary release];
	[array release];
	[super dealloc];
}

#endif

@end
