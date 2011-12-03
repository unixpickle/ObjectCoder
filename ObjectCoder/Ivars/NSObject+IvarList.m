//
//  NSObject+IvarList.m
//  ObjectCoderTest
//
//  Created by Alex Nichol on 12/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NSObject+IvarList.h"

#if __has_feature(objc_arc)
#define GETADDRESS(X) (const char *)(__bridge const void *)(X)
#else
#define GETADDRESS(X) (const char *)(X)
#endif

@implementation NSObject (IvarList)

- (NSArray *)instanceVariables {
	unsigned int count = 0;
	Ivar * ivars = class_copyIvarList([self class], &count);
	if (!ivars) {
		return [NSArray array];
	}
	
	NSMutableArray * infoObjects = [[NSMutableArray alloc] initWithCapacity:count];
	for (unsigned int i = 0; i < count; i++) {
		Ivar anIvar = ivars[i];
		NSString * name = [NSString stringWithUTF8String:ivar_getName(anIvar)];
		NSString * typeEncoding = [NSString stringWithUTF8String:ivar_getTypeEncoding(anIvar)];
		[infoObjects addObject:[OCIvarInfo ivarInfoWithName:name typeEncoding:typeEncoding]];
	}
	
	free(ivars);
	
#if __has_feature(objc_arc)
	return [infoObjects copy]; // create immutable copy
#else
	NSArray * immutable = [NSArray arrayWithArray:infoObjects];
	[infoObjects release];
	return immutable;
#endif
}

#pragma mark - Ivar Getters -

- (Ivar)getInstanceVariable:(NSString *)ivarName {
	Ivar ivar = class_getInstanceVariable([self class], [ivarName UTF8String]);
	if (!ivar) {
		@throw [NSException exceptionWithName:OCIvarNotFoundException
									   reason:@"The ivar specified does not exist."
									 userInfo:nil];
	}
	return ivar;
}

- (id)getInstanceVariableObject:(NSString *)ivarName {
	Ivar ivar = [self getInstanceVariable:ivarName];
	return object_getIvar(self, ivar);
}

#pragma mark Scalar (Signed)

- (char)getInstanceVariableChar:(NSString *)ivarName {
	Ivar ivar = [self getInstanceVariable:ivarName];
	return *(GETADDRESS(self) + ivar_getOffset(ivar));
}

- (short)getInstanceVariableShort:(NSString *)ivarName {
	Ivar ivar = [self getInstanceVariable:ivarName];
	return *(short *)(GETADDRESS(self) + ivar_getOffset(ivar));
}

- (int)getInstanceVariableInt:(NSString *)ivarName {
	Ivar ivar = [self getInstanceVariable:ivarName];
	return *(int *)(GETADDRESS(self) + ivar_getOffset(ivar));
}

- (long)getInstanceVariableLong:(NSString *)ivarName {
	Ivar ivar = [self getInstanceVariable:ivarName];
	return *(long *)(GETADDRESS(self) + ivar_getOffset(ivar));
}

- (long long)getInstanceVariableLongLong:(NSString *)ivarName {
	Ivar ivar = [self getInstanceVariable:ivarName];
	return *(long long *)(GETADDRESS(self) + ivar_getOffset(ivar));
}

#pragma mark Scalar (Unsigned)

- (unsigned char)getInstanceVariableUnsignedChar:(NSString *)ivarName {
	Ivar ivar = [self getInstanceVariable:ivarName];
	return *(unsigned char *)(GETADDRESS(self) + ivar_getOffset(ivar));
}

- (unsigned short)getInstanceVariableUnsignedShort:(NSString *)ivarName {
	Ivar ivar = [self getInstanceVariable:ivarName];
	return *(unsigned short *)(GETADDRESS(self) + ivar_getOffset(ivar));
}

- (unsigned int)getInstanceVariableUnsignedInt:(NSString *)ivarName {
	Ivar ivar = [self getInstanceVariable:ivarName];
	return *(unsigned int *)(GETADDRESS(self) + ivar_getOffset(ivar));
}

- (unsigned long)getInstanceVariableUnsignedLong:(NSString *)ivarName {
	Ivar ivar = [self getInstanceVariable:ivarName];
	return *(unsigned long *)(GETADDRESS(self) + ivar_getOffset(ivar));
}

- (unsigned long long)getInstanceVariableUnsignedLongLong:(NSString *)ivarName {
	Ivar ivar = [self getInstanceVariable:ivarName];
	return *(unsigned long long *)(GETADDRESS(self) + ivar_getOffset(ivar));
}

#pragma mark Misc Scalar

- (float)getInstanceVariableFloat:(NSString *)ivarName {
	Ivar ivar = [self getInstanceVariable:ivarName];
	return *(float *)(GETADDRESS(self) + ivar_getOffset(ivar));
}

- (double)getInstanceVariableDouble:(NSString *)ivarName {
	Ivar ivar = [self getInstanceVariable:ivarName];
	return *(double *)(GETADDRESS(self) + ivar_getOffset(ivar));
}

- (_Bool)getInstanceVariableBool:(NSString *)ivarName {
	Ivar ivar = [self getInstanceVariable:ivarName];
	return *(_Bool *)(GETADDRESS(self) + ivar_getOffset(ivar));
}

- (void *)getInstanceVariablePointer:(NSString *)ivarName {
	Ivar ivar = [self getInstanceVariable:ivarName];
	return *(void **)(GETADDRESS(self) + ivar_getOffset(ivar));
}

#pragma mark - Ivar Setters -

- (void)setInstanceVariable:(NSString *)ivarName withObject:(id)anObject {
	object_setIvar(self, [self getInstanceVariable:ivarName], anObject);
#if !__has_feature(objc_arc)
	[anObject retain];
#endif
}

#pragma mark Scalar (Unsigned)

- (void)setInstanceVariable:(NSString *)ivarName withChar:(char)aScalar {
	Ivar ivar = [self getInstanceVariable:ivarName];
	*(char *)(GETADDRESS(self) + ivar_getOffset(ivar)) = aScalar;
}

- (void)setInstanceVariable:(NSString *)ivarName withShort:(short)aScalar {
	Ivar ivar = [self getInstanceVariable:ivarName];
	*(short *)(GETADDRESS(self) + ivar_getOffset(ivar)) = aScalar;
}

- (void)setInstanceVariable:(NSString *)ivarName withInt:(int)aScalar {
	Ivar ivar = [self getInstanceVariable:ivarName];
	*(int *)(GETADDRESS(self) + ivar_getOffset(ivar)) = aScalar;
}

- (void)setInstanceVariable:(NSString *)ivarName withLong:(long)aScalar {
	Ivar ivar = [self getInstanceVariable:ivarName];
	*(long *)(GETADDRESS(self) + ivar_getOffset(ivar)) = aScalar;
}

- (void)setInstanceVariable:(NSString *)ivarName withLongLong:(long long)aScalar {
	Ivar ivar = [self getInstanceVariable:ivarName];
	*(long long *)(GETADDRESS(self) + ivar_getOffset(ivar)) = aScalar;
}

#pragma mark Scalar (Signed)

- (void)setInstanceVariable:(NSString *)ivarName withUnsignedChar:(unsigned char)aScalar {
	Ivar ivar = [self getInstanceVariable:ivarName];
	*(unsigned char *)(GETADDRESS(self) + ivar_getOffset(ivar)) = aScalar;
}

- (void)setInstanceVariable:(NSString *)ivarName withUnsignedShort:(unsigned short)aScalar {
	Ivar ivar = [self getInstanceVariable:ivarName];
	*(unsigned short *)(GETADDRESS(self) + ivar_getOffset(ivar)) = aScalar;
}

- (void)setInstanceVariable:(NSString *)ivarName withUnsignedInt:(unsigned int)aScalar {
	Ivar ivar = [self getInstanceVariable:ivarName];
	*(unsigned int *)(GETADDRESS(self) + ivar_getOffset(ivar)) = aScalar;
}

- (void)setInstanceVariable:(NSString *)ivarName withUnsignedLong:(unsigned long)aScalar {
	Ivar ivar = [self getInstanceVariable:ivarName];
	*(unsigned long *)(GETADDRESS(self) + ivar_getOffset(ivar)) = aScalar;
}

- (void)setInstanceVariable:(NSString *)ivarName withUnsignedLongLong:(unsigned long long)aScalar {
	Ivar ivar = [self getInstanceVariable:ivarName];
	*(unsigned long long *)(GETADDRESS(self) + ivar_getOffset(ivar)) = aScalar;
}

#pragma mark Misc Scalar

- (void)setInstanceVariable:(NSString *)ivarName withFloat:(float)aScalar {
	Ivar ivar = [self getInstanceVariable:ivarName];
	*(float *)(GETADDRESS(self) + ivar_getOffset(ivar)) = aScalar;
}

- (void)setInstanceVariable:(NSString *)ivarName withDouble:(double)aScalar {
	Ivar ivar = [self getInstanceVariable:ivarName];
	*(double *)(GETADDRESS(self) + ivar_getOffset(ivar)) = aScalar;
}

- (void)setInstanceVariable:(NSString *)ivarName withBool:(_Bool)aScalar {
	Ivar ivar = [self getInstanceVariable:ivarName];
	*(_Bool *)(GETADDRESS(self) + ivar_getOffset(ivar)) = aScalar;
}

- (void)setInstanceVariable:(NSString *)ivarName withPointer:(void *)aScalar {
	Ivar ivar = [self getInstanceVariable:ivarName];
	*(void **)(GETADDRESS(self) + ivar_getOffset(ivar)) = aScalar;
}

@end
