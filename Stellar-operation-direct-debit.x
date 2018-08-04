// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"
%#include "xdr/Stellar-operation-payment.h"

namespace stellar
{

struct DirectDebitOp
{
    AccountID from;
    PaymentOp paymentOp;
	 // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* Payment Result ********/

enum DirectDebitResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0, // payment successfuly completed

    // codes considered as "failure" for the operation
    MALFORMED = -1,       // bad input
    UNDERFUNDED = -2,     // not enough funds in source account
    LINE_FULL = -3,       // destination would go above their limit
	FEE_MISMATCHED = -4,   // fee is not equal to expected fee
    BALANCE_NOT_FOUND = -5, // destination balance not found
    BALANCE_ACCOUNT_MISMATCHED = -6,
    BALANCE_ASSETS_MISMATCHED = -7,
	SRC_BALANCE_NOT_FOUND = -8, // source balance not found
    REFERENCE_DUPLICATION = -9,
    STATS_OVERFLOW = -10,
    LIMITS_EXCEEDED = -11,
    NOT_ALLOWED_BY_ASSET_POLICY = -12,
    NO_TRUST = -13
};

struct DirectDebitSuccess {
	PaymentResponse paymentResponse;
	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union DirectDebitResult switch (DirectDebitResultCode code)
{
case SUCCESS:
    DirectDebitSuccess success;
default:
    void;
};

}
