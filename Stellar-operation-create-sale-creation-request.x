// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* CreateSaleCreationRequestOp

    Creates Sale creation request

    Threshold: high

    Result: CreateSaleCreationRequestResult
*/

struct CreateSaleCreationRequestOp
{
	uint64 requestID;
    SaleCreationRequest request;

	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;

};

/******* CreateSaleCreationRequest Result ********/

enum CreateSaleCreationRequestResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
	REQUEST_NOT_FOUND = -1, // trying to update reviewable request which does not exists
	BASE_ASSET_OR_ASSET_REQUEST_NOT_FOUND = -2, // failed to find asset or asset request for sale
	QUOTE_ASSET_NOT_FOUND = -3, // failed to find quote asset
	START_END_INVALID = -4, // sale ends before start
	INVALID_END = -5, // end date is in the past
	INVALID_PRICE = -6, // price can not be 0
	INVALID_CAP = -7, // hard cap is < soft cap
	INSUFFICIENT_MAX_ISSUANCE = -8, // max number of tokens is less then number of tokens required for soft cap
	INVALID_ASSET_PAIR = -9, // one of the assets has invalid code or base asset is equal to quote asset
	REQUEST_OR_SALE_ALREADY_EXISTS = -10,
	INSUFFICIENT_PREISSUED = -11, // amount of pre issued tokens is insufficient for hard cap
	INVALID_DETAILS = -12, // details must be a valid json
	VERSION_IS_NOT_SUPPORTED_YET = -13 // version specified in request is not supported yet
};

struct CreateSaleCreationSuccess {
	uint64 requestID;

	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};


union CreateSaleCreationRequestResult switch (CreateSaleCreationRequestResultCode code)
{
    case SUCCESS:
        CreateSaleCreationSuccess success;
    default:
        void;
};

}
