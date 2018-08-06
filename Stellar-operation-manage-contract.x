// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* Adds details to contract, starts disputes, confirms contract

Threshold: med

Result: ManageContractResult
*/

enum ManageContractAction
{
    ADD_DETAILS = 0,
    CONFIRM_COMPLETED = 1,
    START_DISPUTE = 2
};

struct ManageContractOp
{
    uint64 contractID;

    union switch (ManageContractAction action)
    {
    case ADD_DETAILS:
        longstring details;
    case CONFIRM_COMPLETED:
        void;
    case START_DISPUTE:
        longstring disputeReason;
    }
    data;

	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageContract Result ********/

enum ManageContractResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    MALFORMED = -1,
    NOT_FOUND = -2, // not found contract
    NOT_ALLOWED = -3, // only contractor or customer can add details
    TOO_MANY_CONTRACT_DETAILS = -4,
    DETAILS_TOO_LONG = -5,
    ALREADY_BOTH_CONFIRMED = -6,
    ALREADY_CONTRACTOR_CONFIRMED = -7,
    ALREADY_CUSTOMER_CONFIRMED = -8,
    INVOICE_NOT_APPROVED = -9 // all contract invoices must be approved
};

struct ManageContractResponse
{
    union switch (ManageContractAction action)
    {
    case ADD_DETAILS:
        void;
    case CONFIRM_COMPLETED:
        bool isCompleted;
    case START_DISPUTE:
        void;
    }
    data;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union ManageContractResult switch (ManageContractResultCode code)
{
case SUCCESS:
    ManageContractResponse response;
default:
    void;
};

}
