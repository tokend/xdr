// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-reviewable-request-AML-alert.h"

namespace stellar
{

/* CreateAMLAlertRequestOp

    Creates AML alert request

    Threshold: high

    Result: CreateAMLAlertRequestResult
*/

struct CreateAMLAlertRequestOp
{
    string64 reference;
    AMLAlertRequest amlAlertRequest;

	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;

};

/******* CreateSaleCreationRequest Result ********/

enum CreateAMLAlertRequestResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,
    BALANCE_NOT_EXIST = 1, // balance doesn't exist
    INVALID_REASON = 2, //invalid reason for request
    UNDERFUNDED = 3, //when couldn't lock balance
	REFERENCE_DUPLICATION = 4, // reference already exists
	INVALID_AMOUNT = 5 // amount must be positive


};

struct CreateAMLAlertRequestSuccess {
	uint64 requestID;

	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};


union CreateAMLAlertRequestResult switch (CreateAMLAlertRequestResultCode code)
{
    case SUCCESS:
        CreateAMLAlertRequestSuccess success;
    default:
        void;
};

}
