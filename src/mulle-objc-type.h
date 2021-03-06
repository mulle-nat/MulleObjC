//
//  ns_objc_type.h
//  MulleObjC
//
//  Copyright (c) 2015 Nat! - Mulle kybernetiK.
//  Copyright (c) 2015 Codeon GmbH.
//  All rights reserved.
//
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  Redistributions of source code must retain the above copyright notice, this
//  list of conditions and the following disclaimer.
//
//  Redistributions in binary form must reproduce the above copyright notice,
//  this list of conditions and the following disclaimer in the documentation
//  and/or other materials provided with the distribution.
//
//  Neither the name of Mulle kybernetiK nor the names of its contributors
//  may be used to endorse or promote products derived from this software
//  without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.
//

// This header should be includeable by C and must not require inclusion
// or link the runtime

#ifndef mulle_objc_type__h__
#define mulle_objc_type__h__

/*
 * Try to stay minimal here.
 * The minimal stuff provided by the runtime, should not force the user to
 * create a universe. It should keep the namespace as free as possible from
 * dependencies.
 */
#include <mulle-objc-runtime/minimal.h>

//
// this should be C readable
// these are here in the header, but they are actually defined by the
// compiler. So you can't really change them.
//
// --- compiler defined begin ---
typedef void                            *id;
typedef struct _mulle_objc_infraclass   *Class;  // the meta-class is not "visible" to Class users

//
// "Protocol" as a valid keyword and a pseudo-class does not exist
// @protocol( Foo) returns a mulle_objc_protocolid_t, which is an "uint32_t"
// For other compilers say   `typedef Protocol   *PROTOCOL`
// and code will work on both sides.
//
typedef mulle_objc_methodid_t       SEL;
typedef mulle_objc_protocolid_t     PROTOCOL;
typedef struct _mulle_objc_method   *Method;
typedef struct _mulle_objc_ivar     *Ivar;
typedef id                          (*IMP)( id, SEL, void *);

// --- compiler defined end ---

// turn off this warning, because it's wrong for us
#pragma clang diagnostic ignored "-Wcast-of-sel-type"


//
// in AAM define some harmless syntax sugar, so more stuff compiles
//
#ifdef __OBJC_AAM__
# define __bridge
# define __unsafe_unretained
#endif


#define nil   ((id) 0)
#define Nil   ((Class) 0)

// idee ? statt isa
// #define Self  object_getClass( self)

// defined some Apple macros, for easier compilation and porting

#define NS_ASSUME_NONNULL_BEGIN
#define NS_ASSUME_NONNULL_END
#define NS_SWIFT_NAME( unused)
#define NS_SWIFT_UNAVAILABLE( unused)
#define NS_REQUIRES_NIL_TERMINATION

// https://nshipster.com/ns_enum-ns_options/
#define NS_ENUM(_type, _name) enum _name : _type _name; enum _name : _type
#define NS_OPTIONS(_type, _name) enum _name : _type _name; enum _name : _type

#endif
