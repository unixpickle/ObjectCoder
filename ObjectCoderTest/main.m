//
//  main.m
//  ObjectCoderTest
//
//  Created by Alex Nichol on 12/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+ObjectCoder.h"
#import "TestClass.h"

int main (int argc, const char * argv[]) {
	@autoreleasepool {
		NSDictionary * aDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:9000], @"power_level",
								@"ALL YOUR BASE ARE BELONG TO US", @"message", nil];
		NSArray * anArray = [NSArray arrayWithObjects:@"This", @"is", @"cool", nil];
		TestClass * tc = [[TestClass alloc] initWithNumber:1337
												   message:@"This is an epic h4x"
												dictionary:aDict
													 array:anArray];
		[tc printInfo];
		NSDictionary * serialized = [tc objectCoderSerialization];
		TestClass * dectc = [TestClass objectByDecodingObjectCoderRootObject:serialized];
		[dectc printInfo];
		
#if !__has_feature(objc_arc)
		[tc release];
#endif
	}
	return 0;
}

