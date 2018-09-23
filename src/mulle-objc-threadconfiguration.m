//
//  ns_threadconfiguration.m
//  MulleObjC
//
//  Copyright (c) 2018 Nat! - Mulle kybernetiK.
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
#import "import-private.h"

#import "mulle-objc-threadconfiguration.h"
#import "MulleObjCExceptionHandler.h"
#import "NSThread.h"


MULLE_C_CONST_NON_NULL_RETURN struct _mulle_objc_threadconfig *
   _mulle_objc_unfailingcreate_threadconfig( void)
{
   struct _mulle_objc_threadconfig       *threadconfig;

   // looks like we are in a "foreign" thread
   // make it our own
   _NSThreadNewRuntimeThread();
   threadconfig = mulle_objc_get_threadconfig();
   if( ! threadconfig)
      mulle_objc_throw_internal_inconsistency_exception( "could not make "
                                  "the current thread a MulleObjC thread");
   return( threadconfig);
}


MULLE_C_CONST_NON_NULL_RETURN struct _mulle_objc_threadlocalconfiguration  *
   mulle_objc_get_threadlocalconfiguration( void)
{
   struct _mulle_objc_threadconfig               *threadconfig;
   struct _mulle_objc_threadlocalconfiguration   *local;
   struct _mulle_objc_threadlocalconfiguration   *
         _mulle_objc_unfailingcreate_threadlocalconfiguration( void);

   assert( S_MULLE_OBJC_THREADCONFIG_FOUNDATION_SPACE >=
           sizeof( struct _mulle_objc_threadlocalconfiguration));

   threadconfig = mulle_objc_get_threadconfig();
   if( ! threadconfig)
      threadconfig = _mulle_objc_unfailingcreate_threadconfig();
   local = _mulle_objc_threadconfig_get_foundationspace( threadconfig);
   return( local);
}
