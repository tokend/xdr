// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-types.h"
%#include "xdr/Stellar-reviewable-request-update-KYC.h"
namespace stellar
{

struct UpdateKYCRequestData {
    AccountID accountToUpdateKYC;
	AccountType accountTypeToSet;
	uint32 kycLevel;
    longstring kycData;
	uint32 allTasks;

	// Reserved for future use
	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct CreateUpdateKYCRequestOp {
    uint64 requestID;
    UpdateKYCRequestData updateKYCRequestData;
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* CreateUpdateKYCRequest Result ********/

enum CreateUpdateKYCRequestResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    MALFORMED = -1,
    UPDATED_ACC_NOT_EXIST = -2, // account does not exists
    REQUEST_EXIST = -3,
	SET_TYPE_THE_SAME = -4, // if account type and kyc level the same that account have
	REQUEST_NOT_EXIST = -5
};

union CreateUpdateKYCRequestResult switch (CreateUpdateKYCRequestResultCode code)
{
case SUCCESS:
    struct {
		uint64 requestID;
		bool fulfilled;
		// Reserved for future use
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