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
	NSDictionary * dictionary;
	NSArray * array;
}

- (id)initWithNumber:(int)aNumber 
			 message:(NSString *)aMessage 
		  dictionary:(NSDictionary *)aDictionary 
			   array:(NSArray *)anArray;

- (void)printInfo;

@end
