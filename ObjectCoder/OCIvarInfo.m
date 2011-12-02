//
//  OCIvarInfo.m
//  ObjectCoderTest
//
//  Created by Alex Nichol on 12/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "OCIvarInfo.h"

@implementation OCIvarInfo

@synthesize name;
@synthesize typeEncoding;

- (id)initWithName:(NSString *)aName typeEncoding:(NSString *)aTypeEncoding {
	if ((self = [super init])) {
		self.name = aName;
		self.typeEncoding = aTypeEncoding;
	}
	return self;
}

+ (OCIvarInfo *)ivarInfoWithName:(NSString *)aName typeEncoding:(NSString *)aTypeEncoding {
	OCIvarInfo * obj = [[OCIvarInfo alloc] initWithName:aName typeEncoding:aTypeEncoding];
#if !__has_feature(objc_arc)
	return [obj autorelease];
#else
	return obj;
#endif
}

#if !__has_feature(objc_arc)
- (void)dealloc {
	self.name = nil;
	self.typeEncoding = nil;
	[super dealloc];
}
#endif

@end
