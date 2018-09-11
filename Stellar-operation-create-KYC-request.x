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
	uint32 kycLevelToSet;
    longstring kycData;
	uint32* allTasks;

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
    ACC_TO_UPDATE_DOES_NOT_EXIST = -1, // account to update does not exist
    REQUEST_ALREADY_EXISTS = -2,
	SAME_ACC_TYPE_TO_SET = -3,
	REQUEST_DOES_NOT_EXIST = -4,
	PENDING_REQUEST_UPDATE_NOT_ALLOWED = -5,
	NOT_ALLOWED_TO_UPDATE_REQUEST = -6, // master account can update request only through review request operation
	INVALID_UPDATE_KYC_REQUEST_DATA = -7,
	INVALID_KYC_DATA = -8,
	KYC_RULE_NOT_FOUND = -9
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