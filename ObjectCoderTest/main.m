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
		TestClass * tc = [[TestClass alloc] initWithNumber:1337
												   message:@"This is an epic h4x"];
		[tc printInfo];
		NSDictionary * serialized = [tc objectCoderSerialization];
		TestClass * dectc = [TestClass objectByDecodingObjectCoderRootObject:serialized];
		[dectc printInfo];
	}
	return 0;
}

