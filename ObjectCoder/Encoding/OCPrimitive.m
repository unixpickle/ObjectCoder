//
//  OCPrimitiveEncode.m
//  ObjectCoderTest
//
//  Created by Alex Nichol on 12/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "OCPrimitive.h"

#pragma mark Type Checking

BOOL OCTypeEncodingIsObject (NSString * type) {
	if ([type hasPrefix:@"@"]) {
		return YES;
	}
	return NO;
}

BOOL OCIvarIsPrimitive (OCIvarInfo * anIvar) {
	NSString * type = anIvar.typeEncoding;
	const char * primTypes[] = {
		@encode(long long),
		@encode(long),
		@encode(int),
		@encode(short),
		@encode(char),
		@encode(unsigned long long),
		@encode(unsigned long),
		@encode(unsigned int),
		@encode(unsigned short),
		@encode(unsigned char),
		@encode(_Bool),
		@encode(void *),
		@encode(float),
		@encode(double),
		NULL
	};
	int i = 0;
	while (primTypes[i] != NULL) {
		if ([type isEqualToString:[NSString stringWithUTF8String:primTypes[i]]]) {
			return YES;
		}
		i++;
	}
	return NO;
}

#pragma mark Encoding

NSDictionary * OCEncodePrimitive (NSString * className, NSString * type, id pvalue) {
	if (className) {
		return [NSDictionary dictionaryWithObjectsAndKeys:className, @"class",
				type, @"type", pvalue, @"pvalue", nil];
	} else {
		return [NSDictionary dictionaryWithObjectsAndKeys:type, @"type",
				pvalue, @"pvalue", nil];		
	}
}

NSDictionary * OCEncodePrimitiveIvar (NSObject * object, OCIvarInfo * anIvar) {
	NSNumber * value = nil;
	const char * typeStr = [anIvar.typeEncoding UTF8String];
	// compare types
	if (strcmp(typeStr, @encode(char)) == 0) {
		value = [NSNumber numberWithChar:[object getInstanceVariableChar:[anIvar name]]];
	} else if (strcmp(typeStr, @encode(unsigned char)) == 0) {
		value = [NSNumber numberWithUnsignedChar:[object getInstanceVariableUnsignedChar:[anIvar name]]];
	} else if (strcmp(typeStr, @encode(short)) == 0) {
		value = [NSNumber numberWithShort:[object getInstanceVariableShort:[anIvar name]]];
	} else if (strcmp(typeStr, @encode(unsigned short)) == 0) {
		value = [NSNumber numberWithUnsignedShort:[object getInstanceVariableUnsignedShort:[anIvar name]]];
	} else if (strcmp(typeStr, @encode(int)) == 0) {
		value = [NSNumber numberWithInt:[object getInstanceVariableInt:[anIvar name]]];
	}else if (strcmp(typeStr, @encode(unsigned int)) == 0) {
		value = [NSNumber numberWithUnsignedInt:[object getInstanceVariableUnsignedInt:[anIvar name]]];
	} else if (strcmp(typeStr, @encode(long)) == 0) {
		value = [NSNumber numberWithLong:[object getInstanceVariableLong:[anIvar name]]];
	} else if (strcmp(typeStr, @encode(unsigned long)) == 0) {
		value = [NSNumber numberWithUnsignedLong:[object getInstanceVariableUnsignedLong:[anIvar name]]];
	} else if (strcmp(typeStr, @encode(long long)) == 0) {
		value = [NSNumber numberWithLongLong:[object getInstanceVariableLongLong:[anIvar name]]];
	} else if (strcmp(typeStr, @encode(unsigned long long)) == 0) {
		value = [NSNumber numberWithUnsignedLongLong:[object getInstanceVariableUnsignedLongLong:[anIvar name]]];
	} else if (strcmp(typeStr, @encode(_Bool)) == 0) {
		value = [NSNumber numberWithBool:(BOOL)[object getInstanceVariableBool:[anIvar name]]];
	} else if (strcmp(typeStr, @encode(void *)) == 0) {
		value = OCNumberFromPtr([object getInstanceVariablePointer:[anIvar name]]);
	} else if (strcmp(typeStr, @encode(float)) == 0) {
		value = [NSNumber numberWithFloat:[object getInstanceVariableFloat:[anIvar name]]];
	} else if (strcmp(typeStr, @encode(double)) == 0) {
		value = [NSNumber numberWithDouble:[object getInstanceVariableDouble:[anIvar name]]];
	}
	if (!value) return nil;
	return OCEncodePrimitive(nil, anIvar.typeEncoding, value);
}

#pragma mark Decoding

BOOL OCDecodeAndSetPrimitiveIvar (id object, NSString * ivarName, NSDictionary * ivarInfo) {
	NSNumber * pvalue = [ivarInfo objectForKey:@"pvalue"];
	if (![pvalue isKindOfClass:[NSNumber class]]) {
		return NO;
	}
	const char * typeStr = [[ivarInfo objectForKey:@"type"] UTF8String];
	if (strcmp(typeStr, @encode(char)) == 0) {
		[object setInstanceVariable:ivarName withChar:[pvalue charValue]];
	} else if (strcmp(typeStr, @encode(short)) == 0) {
		[object setInstanceVariable:ivarName withShort:[pvalue shortValue]];
	} else if (strcmp(typeStr, @encode(int)) == 0) {
		[object setInstanceVariable:ivarName withInt:[pvalue intValue]];
	} else if (strcmp(typeStr, @encode(long)) == 0) {
		[object setInstanceVariable:ivarName withLong:[pvalue longValue]];
	} else if (strcmp(typeStr, @encode(long long)) == 0) {
		[object setInstanceVariable:ivarName withLongLong:[pvalue longLongValue]];
	} else if (strcmp(typeStr, @encode(unsigned char)) == 0) {
		[object setInstanceVariable:ivarName withChar:[pvalue charValue]];
	} else if (strcmp(typeStr, @encode(unsigned short)) == 0) {
		[object setInstanceVariable:ivarName withShort:[pvalue shortValue]];
	} else if (strcmp(typeStr, @encode(unsigned int)) == 0) {
		[object setInstanceVariable:ivarName withInt:[pvalue intValue]];
	} else if (strcmp(typeStr, @encode(unsigned long)) == 0) {
		[object setInstanceVariable:ivarName withLong:[pvalue longValue]];
	} else if (strcmp(typeStr, @encode(unsigned long long)) == 0) {
		[object setInstanceVariable:ivarName withLongLong:[pvalue longLongValue]];
	} else if (strcmp(typeStr, @encode(float)) == 0) {
		[object setInstanceVariable:ivarName withFloat:[pvalue floatValue]];
	} else if (strcmp(typeStr, @encode(double)) == 0) {
		[object setInstanceVariable:ivarName withDouble:[pvalue doubleValue]];
	} else if (strcmp(typeStr, @encode(_Bool)) == 0) {
		[object setInstanceVariable:ivarName withBool:(_Bool)[pvalue boolValue]];
	} else if (strcmp(typeStr, @encode(void *)) == 0) {
		[object setInstanceVariable:ivarName withPointer:OCPtrFromNumber(pvalue)];
	} else {
		return NO;
	}
	return YES;
}

#pragma mark Pointers

NSNumber * OCNumberFromPtr (void * ptr) {
#if __WORDSIZE == 64
	return [NSNumber numberWithUnsignedLong:(unsigned long)ptr];
#else
	return [NSNumber numberWithUnsignedLong:(unsigned long long)ptr];
#endif
}

void * OCPtrFromNumber (NSNumber * number) {
#if __WORDSIZE == 64
	return (void *)[number unsignedLongValue];
#else
	return (void *)[number unsignedLongValue];
#endif
}
