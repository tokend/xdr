// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-types.h"
%#include "xdr/Stellar-reviewable-request-change-KYC.h"
namespace stellar
{

struct CreateKYCRequestOp
{
   uint64 requestID;
   ChangeKYCRequest changeKYCRequest;
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};
/******* UpdateKYCLevel Result ********/

enum CreateKYCRequestResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0, // account was created

    // codes considered as "failure" for the operation
    UPDATED_ACC_NOT_EXIST = -1,         // account does not exists
	NOT_ALLOWED = -2,        //set account type operation is not allowed on this account
    REQUEST_EXIST = -3,
	SET_TYPE_THE_SAME = -4,// if account type and kyc level the same that account have
	REQUEST_NOT_EXIST = -5,
	REQUEST_TYPE_MISSMATCH = -6
};
union CreateKYCRequestResult switch (CreateKYCRequestResultCode code)
{
case SUCCESS:
    struct {
		uint64 requestID;
		// reserved for future use
		union switch (LedgerVersion v)
		{
		case EMPTY_VERSION:
			void;
		}
		ext;
	} success;
default:
    void;
};


}