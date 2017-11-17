// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

enum ManageCoinsEmissionRequestAction
{
    MANAGE_COINS_EMISSION_REQUEST_CREATE = 0,
    MANAGE_COINS_EMISSION_REQUEST_DELETE = 1
};


/* ManageCoinsEmissionRequestOp

    Creates, updates or deletes coins emission request

    Threshold: high

    Result: ManageCoinsEmissionRequestResult
*/
struct ManageCoinsEmissionRequestOp
{
	// 0=create a new request, otherwise edit an existing offer
    ManageCoinsEmissionRequestAction action;
	uint64 requestID;
    int64 amount;        // amount being issued. if set to 0, delete the offer
    BalanceID receiver;
    AssetCode asset;
    string64 reference;
	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageCoinsEmissionRequest Result ********/

enum ManageCoinsEmissionRequestResultCode
{
    // codes considered as "success" for the operation
    MANAGE_COINS_EMISSION_REQUEST_SUCCESS = 0,

    // codes considered as "failure" for the operation
    MANAGE_COINS_EMISSION_REQUEST_INVALID_AMOUNT = -1,      // amount is negative
	MANAGE_COINS_EMISSION_REQUEST_INVALID_REQUEST_ID = -2, // not 0 for delete etc
	MANAGE_COINS_EMISSION_REQUEST_NOT_FOUND = -3,           // failed to find emission request with such ID
	MANAGE_COINS_EMISSION_REQUEST_ALREADY_REVIEWED = -4,    // emission request have been already reviewed - can't edit
    MANAGE_COINS_EMISSION_REQUEST_ASSET_NOT_FOUND = -5,
    MANAGE_COINS_EMISSION_REQUEST_BALANCE_NOT_FOUND = -6,
    MANAGE_COINS_EMISSION_REQUEST_ASSET_MISMATCH = -7,
    MANAGE_COINS_EMISSION_REQUEST_INVALID_ASSET = -8,
    MANAGE_COINS_EMISSION_REQUEST_REFERENCE_DUPLICATION = -9,
    MANAGE_COINS_EMISSION_REQUEST_LINE_FULL = -10,
    MANAGE_COINS_EMISSION_REQUEST_INVALID_REFERENCE = -11
};

union ManageCoinsEmissionRequestResult switch (ManageCoinsEmissionRequestResultCode code)
{
case MANAGE_COINS_EMISSION_REQUEST_SUCCESS:
    struct {
        uint64 requestID;
        bool fulfilled;
		union switch (LedgerVersion v)
		{
		case EMPTY_VERSION:
			void;
		}
		ext;
    } manageRequestInfo;
default:
    void;
};

}
