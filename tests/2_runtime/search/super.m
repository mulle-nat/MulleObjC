#import <MulleObjC/MulleObjC.h>


@interface A
@end

@class P;
@protocol P
@end
@interface P < P>
@end

@class Q;
@protocol Q
@end
@interface Q < Q>
@end

@interface B : A < P, Q>
@end
@interface B( C)
@end


@implementation A
+ (id) new
{
   return( _mulle_objc_infraclass_alloc_instance( self,  NULL));
}
- (Class) class
{
   return( self);
}
- (void) dealloc
{
   _mulle_objc_object_free( self, NULL);
}
+ (void) foo
{
   printf( "%s\n", __PRETTY_FUNCTION__);
}
- (void) foo
{
   printf( "%s\n", __PRETTY_FUNCTION__);
}
@end


@implementation P
+ (void) foo
{
   printf( "%s\n", __PRETTY_FUNCTION__);
}
- (void) foo
{
   printf( "%s\n", __PRETTY_FUNCTION__);
}
@end

@implementation Q
+ (void) foo
{
   printf( "%s\n", __PRETTY_FUNCTION__);
}
- (void) foo
{
   printf( "%s\n", __PRETTY_FUNCTION__);
}
@end

@implementation B
+ (void) foo
{
   printf( "%s\n", __PRETTY_FUNCTION__);
}
- (void) foo
{
   printf( "%s\n", __PRETTY_FUNCTION__);
}
@end
@implementation B( C)
+ (void) foo
{
   printf( "%s\n", __PRETTY_FUNCTION__);
}
- (void) foo
{
   printf( "%s\n", __PRETTY_FUNCTION__);
}
@end


static void   test_super( id obj,
                          SEL methodsel,
                          SEL classsel,
                          struct _mulle_objc_infraclass *infraclass,
                          struct _mulle_objc_metaclass *metaclass)

{
   struct _mulle_objc_searchargumentscachable    args;
   struct _mulle_objc_searchargumentscachable    before;
   struct _mulle_objc_method                     *method;
   IMP    imp;

   _mulle_objc_searchargumentscacheable_superinit( &args, methodsel, classsel);
   before = args;
   method = mulle_objc_class_search_method( &infraclass->base, &args, &infraclass->base.inheritance, NULL);
   imp    = _mulle_objc_method_get_implementation( method);
   (*imp)( obj, methodsel, obj);

   assert( ! memcmp( &args, &before, sizeof( args)));

   method = mulle_objc_class_search_method( &metaclass->base, &args, &metaclass->base.inheritance, NULL);
   imp    = _mulle_objc_method_get_implementation( method);
   (*imp)( obj, methodsel, obj);
}


int   main()
{
   B      *b;
   struct _mulle_objc_infraclass  *infraclass;
   struct _mulle_objc_metaclass   *metaclass;

   mulle_objc_htmldump_universe();

   b = [B new];
   infraclass = [B class];
   metaclass  = _mulle_objc_infraclass_get_metaclass( infraclass);

   test_super( b, @selector( foo), @selector( B), infraclass, metaclass);
   test_super( b, @selector( foo), @selector( Q), infraclass, metaclass);
   test_super( b, @selector( foo), @selector( P), infraclass, metaclass);

   [b dealloc];
}