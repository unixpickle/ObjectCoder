//
//  TestClass.m
//  ObjectCoderTest
//
//  Created by Alex Nichol on 12/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TestClass.h"

@implementation TestClass

- (id)initWithNumber:(int)aNumber message:(NSString *)aMessage {
	if ((self = [super init])) {
		number = aNumber;
#if __has_feature(objc_arc)
		message = aMessage;
#else
		message = [aMessage retain];
#endif
	}
	return self;
}

- (void)printInfo {
	NSLog(@"%d ... %@", number, message);
}

@end
