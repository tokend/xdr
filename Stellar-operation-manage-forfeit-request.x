// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* ManageForfeitRequestOp

    Creates, updates or deletes forfeit request

    Threshold: high

    Result: ManageForfeitRequestResult
*/

struct ManageForfeitRequestOp
{
    BalanceID balance;
    int64 amount;
	int64 totalFee;
    string details<>;
	AccountID reviewer;

	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;

};

/******* ManageForfeitRequest Result ********/

enum ManageForfeitRequestResultCode
{
    // codes considered as "success" for the operation
    MANAGE_FORFEIT_REQUEST_SUCCESS = 0,

    // codes considered as "failure" for the operation
	MANAGE_FORFEIT_REQUEST_UNDERFUNDED = -1,
    MANAGE_FORFEIT_REQUEST_INVALID_AMOUNT = -2,
    MANAGE_FORFEIT_REQUEST_LINE_FULL = -3,
    MANAGE_FORFEIT_REQUEST_BALANCE_MISMATCH = -4,
    MANAGE_FORFEIT_REQUEST_STATS_OVERFLOW = -5,
    MANAGE_FORFEIT_REQUEST_LIMITS_EXCEEDED = -6,
    MANAGE_FORFEIT_REQUEST_REVIEWER_NOT_FOUND = -7,
    MANAGE_FORFEIT_REQUEST_INVALID_DETAILS = -8,
	MANAGE_FORFEIT_REQUEST_FEE_MISMATCH = -9 // fee is not equal to expected fee
};


union ManageForfeitRequestResult switch (ManageForfeitRequestResultCode code)
{
    case MANAGE_FORFEIT_REQUEST_SUCCESS:
        struct
        {
            uint64 paymentID;

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
