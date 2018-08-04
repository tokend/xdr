// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{


/* CreateIssuanceRequestOp

    Creates or deletes issuance request

    Threshold: high

    Result: CreateIssuanceRequestResult
*/
struct CreateIssuanceRequestOp
{
	IssuanceRequest request;
	string64 reference;
	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* CreateIssuanceRequest Result ********/

enum CreateIssuanceRequestResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    ASSET_NOT_FOUND = -1,
	INVALID_AMOUNT = -2,
	REFERENCE_DUPLICATION = -3,
	NO_COUNTERPARTY = -4,
	NOT_AUTHORIZED = -5,
	EXCEEDS_MAX_ISSUANCE_AMOUNT = -6,
	RECEIVER_FULL_LINE = -7,
	INVALID_EXTERNAL_DETAILS = -8, // external details size exceeds max allowed
	FEE_EXCEEDS_AMOUNT = -9, // fee more than amount to issue
    REQUIRES_KYC = -10, // asset requires receiver to have KYC
    REQUIRES_VERIFICATION = -11 //asset requires receiver to be verified
};

struct CreateIssuanceRequestSuccess {
	uint64 requestID;
	AccountID receiver;
	bool fulfilled;
	Fee fee;
	union switch (LedgerVersion v)
	{
	case EMPTY_VERSION:
		void;
	}
	ext;
};

union CreateIssuanceRequestResult switch (CreateIssuanceRequestResultCode code)
{
case SUCCESS:
    CreateIssuanceRequestSuccess success;
default:
    void;
};

}
