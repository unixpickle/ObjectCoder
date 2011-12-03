//
//  TestClass.h
//  ObjectCoderTest
//
//  Created by Alex Nichol on 12/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestClass : NSObject {
	int number;
	NSString * message;
}

- (id)initWithNumber:(int)aNumber message:(NSString *)aMessage;

- (void)printInfo;

@end
