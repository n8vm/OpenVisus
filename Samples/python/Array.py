## -----------------------------------------------------------------------------
## Copyright(c) 2010 - 2018 ViSUS L.L.C.,
## Scientific Computing and Imaging Institute of the University of Utah
## 
## ViSUS L.L.C., 50 W.Broadway, Ste. 300, 84101 - 2044 Salt Lake City, UT
## University of Utah, 72 S Central Campus Dr, Room 3750, 84112 Salt Lake City, UT
## 
## All rights reserved.
## 
## Redistribution and use in source and binary forms, with or without
## modification, are permitted provided that the following conditions are met :
## 
## * Redistributions of source code must retain the above copyright notice, this
## list of conditions and the following disclaimer.
## 
## * Redistributions in binary form must reproduce the above copyright notice,
## this list of conditions and the following disclaimer in the documentation
## and/or other materials provided with the distribution.
## 
## * Neither the name of the copyright holder nor the names of its
## contributors may be used to endorse or promote products derived from
## this software without specific prior written permission.
## 
## THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
## AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
## IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
## DISCLAIMED.IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
## FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
## DAMAGES(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
## SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
## CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
## OR TORT(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
## OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
## 
## For additional information about this project contact : pascucci@acm.org
## For support : support@visus.net
## -----------------------------------------------------------------------------

import sys
import os
import unittest

import numpy

from OpenVisus import *
from OpenVisus.VisusKernelPy import *


# ////////////////////////////////////////////////////////////////////
class MyTestCase(unittest.TestCase):

  def testInt32Array(self):
    a=Array.fromNumPy(numpy.array( [[1,2,3],[4,5,6]] ,dtype=numpy.int32))
    self.assertEqual(a.dtype.toString(),"int32")
    self.assertEqual(a.dims[0],3)
    self.assertEqual(a.dims[1],2)

  def testFloat32Array(self):
    a = Array.fromNumPy(numpy.array( [[[1],[2]],[[3],[4]],[[5],[6]]],dtype=numpy.float32))
    self.assertEqual(a.dtype.toString(),"float32")
    self.assertEqual(a.dims[0],1)
    self.assertEqual(a.dims[1],2)
    self.assertEqual(a.dims[2],3)

  def testFloat64Array(self):
    a=Array.fromNumPy(numpy.array( [[[1],[2]],[[3],[4]],[[5],[6]]],dtype=numpy.float64)) 
    self.assertEqual(a.dtype.toString(),"float64")
    self.assertEqual(a.dims[0],1)
    self.assertEqual(a.dims[1],2)
    self.assertEqual(a.dims[2],3)

# ////////////////////////////////////////////////////////
if __name__ == '__main__':
  SetCommandLine("__main__")
  KernelModule.attach()
  unittest.main(exit=False)
  KernelModule.detach()


