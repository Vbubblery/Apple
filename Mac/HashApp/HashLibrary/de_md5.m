	//
//  de_md5.m
//  Hash_Md5
//
//  Created by juncheng zhou on 5/22/14.
//
//

#import <CommonCrypto/CommonDigest.h>
#import "FileObject.h"
@implementation NSData(MD5)
NSMutableArray *HashList;
NSMutableArray *SameHash;

- (NSString*)Hash:(int)mode
{

 	// Buffer must be unsigned char
    unsigned char Buffer[CC_MD5_DIGEST_LENGTH];
	// CC_XX(const void *data, CC_LONG len, unsigned char *md)
    //mode=1 =MD5 mode=2 =sha1 mode=3 =sha256
    NSMutableString *output;
    if(mode==1){
        CC_MD5(self.bytes, self.length, Buffer);
         output= [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
        for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
            [output appendFormat:@"%02x",Buffer[i]];
    }
    if (mode==2) {
        CC_SHA1(self.bytes, self.length, Buffer);
         output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
        for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
            [output appendFormat:@"%02x",Buffer[i]];
    }
    if (mode==3) {
        CC_SHA256(self.bytes, self.length, Buffer);
        output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
        for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
            [output appendFormat:@"%02x",Buffer[i]];
    }

    return output;
}

-(NSMutableArray*)arrayHash{
    return HashList;
}
-(NSMutableArray*)arraySameR{
    return SameHash;
}
-(void)AddNewHash:(FileObject*)M5{
    //init array
    if (HashList==nil) {
        HashList=[[NSMutableArray alloc] init];;
    }
    if (SameHash==nil) {
        SameHash=[[NSMutableArray alloc] init];;
    }
    NSArray *array = [[NSArray alloc] initWithObjects:
    M5.Path,M5.Hash,nil];
    [HashList addObject:array];
    
}
-(BOOL)Check:(FileObject*)LatestFile{
    BOOL tmp=NO;
    for (NSArray *k in HashList) {
        //if md5 is the same string.return yes=> these two files are the same file.
        if ([k[1] isEqual:LatestFile.Hash]) {
            [SameHash addObject:[NSString stringWithFormat:@"The latest file %@ is same as %@",LatestFile.Path,k[0]]];
            tmp=YES;
        }
    }
    return tmp;
}
@end

