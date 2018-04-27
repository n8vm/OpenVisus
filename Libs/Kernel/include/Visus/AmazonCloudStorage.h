/*-----------------------------------------------------------------------------
Copyright(c) 2010 - 2018 ViSUS L.L.C.,
Scientific Computing and Imaging Institute of the University of Utah

ViSUS L.L.C., 50 W.Broadway, Ste. 300, 84101 - 2044 Salt Lake City, UT
University of Utah, 72 S Central Campus Dr, Room 3750, 84112 Salt Lake City, UT

All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met :

* Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

* Neither the name of the copyright holder nor the names of its
contributors may be used to endorse or promote products derived from
this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED.IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

For additional information about this project contact : pascucci@acm.org
For support : support@visus.net
-----------------------------------------------------------------------------*/

#ifndef VISUS_AMAZON_CLOUD_STORAGE
#define VISUS_AMAZON_CLOUD_STORAGE

#include <Visus/Kernel.h>
#include <Visus/CloudStorage.h>

namespace Visus {


////////////////////////////////////////////////////////////////////////////////
class VISUS_KERNEL_API AmazonCloudStorage : public CloudStorage
{
public:

  VISUS_CLASS(AmazonCloudStorage)

  //constructor
  AmazonCloudStorage()
  {}

  //destructor
  virtual ~AmazonCloudStorage()
  {}

 // createListOfContainersRequest 
  virtual NetRequest createListOfContainersRequest(Url url) override;
  
  //createCreateContainerRequest
  virtual NetRequest createListOfBlobsRequest(Url url) override;
  
  // createCreateContainerRequest
  virtual NetRequest createCreateContainerRequest(Url url,bool isPublic=true) override;

  // createDeleteContainerRequest
  virtual NetRequest createDeleteContainerRequest(Url url) override;

  // createAddBlobRequest 
  virtual NetRequest createAddBlobRequest(Url url,SharedPtr<HeapMemory> data,StringMap metadata,String content_type = "application/octet-stream") override;

  // createDeleteBlobRequest
  virtual NetRequest createDeleteBlobRequest(Url url) override;

  // createHasBlobRequest 
  virtual NetRequest createHasBlobRequest(Url url) override;

  // createGetBlobRequest 
  virtual NetRequest createGetBlobRequest(Url url) override;

  //getListOfContainers
  virtual StringTree getListOfContainers(NetResponse response) override;

  //getListOfBlobs
  virtual StringTree getListOfBlobs(NetResponse response) override;

  //getMetadata
  virtual StringMap getMetadata(NetResponse response) override;

  //setMetadata
  virtual void setMetadata(NetRequest& request,const StringMap& metadata) override;

protected:

  //isGoodMetaName
  virtual bool isGoodMetaName(String meta_name) override;

  //getMetaDataPrefix
  virtual String getMetaDataPrefix() override
  {return "x-amz-meta-";}

  //signRequest
  virtual bool signRequest(NetRequest& request) override;

};


} //namespace Visus


#endif //VISUS_AMAZON_CLOUD_STORAGE




