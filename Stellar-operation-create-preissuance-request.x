// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* CreatePreIssuanceRequestOp

    Threshold: high

    Result: CreatePreIssuanceRequestOpResult
*/

struct CreatePreIssuanceRequestOp
{
    PreIssuanceRequest request;
	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* CreatePreIssuanceRequest Result ********/

enum CreatePreIssuanceRequestResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    ASSET_NOT_FOUND = -1,
    REFERENCE_DUPLICATION = -2,    // reference is already used
    NOT_AUTHORIZED_UPLOAD = -3, // tries to pre issue asset for not owned asset
    INVALID_SIGNATURE = -4,
    EXCEEDED_MAX_AMOUNT = -5,
	INVALID_AMOUNT = -6,
	INVALID_REFERENCE = -7
};

union CreatePreIssuanceRequestResult switch (CreatePreIssuanceRequestResultCode code)
{
case SUCCESS:
    struct {
		uint64 requestID;
		bool fulfilled;
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
