//
//  ns_threadinfouration.m
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

#import "mulle-objc-threadfoundationinfo.h"
#import "MulleObjCExceptionHandler.h"
#import "MulleObjCExceptionHandler-Private.h"
#import "NSThread.h"


MULLE_C_CONST_NONNULL_RETURN
struct _mulle_objc_threadfoundationinfo  *
   mulle_objc_thread_get_threadfoundationinfo( struct _mulle_objc_universe *universe)
{
   struct _mulle_objc_threadinfo             *threadinfo;
   struct _mulle_objc_threadfoundationinfo   *local;

   assert( S_MULLE_OBJC_THREADCONFIG_FOUNDATION_SPACE >=
           sizeof( struct _mulle_objc_threadfoundationinfo));

   threadinfo = __mulle_objc_thread_get_threadinfo( universe);
   if( ! threadinfo)
   {
      // this will create NSThread and the NSAutoreleasePool
      _MulleThreadCreateThreadObjectInUniverse( universe);

      threadinfo = __mulle_objc_thread_get_threadinfo( universe);
      if( ! threadinfo)
         mulle_objc_universe_fail_inconsistency( universe, "could not make "
                                     "the current thread a MulleObjC thread");
   }

   local = _mulle_objc_threadinfo_get_foundationspace( threadinfo);
   return( local);
}

