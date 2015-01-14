//
//  de_md5.h
//  Hash_Md5
//
//  Created by juncheng zhou on 5/22/14.
//
//
#import "de_md5.h"
#import <Foundation/Foundation.h>
#import "FileObject.h"
@interface NSData(MD5)

- (void)AddNewHash:(FileObject*)M5;
- (NSString *)Hash:(int)mode;
-(BOOL)Check:(FileObject*)LatestFile;
-(NSMutableArray*)arrayHash;
-(NSMutableArray*)arraySameR;
@end
