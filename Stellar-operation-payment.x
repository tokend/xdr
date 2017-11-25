// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* Payment

    Send an amount in specified asset to a destination account.

    Threshold: med

    Result: PaymentResult
*/

struct InvoiceReference {
    uint64 invoiceID;
    bool accept;
	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct FeeData {
    int64 paymentFee;
    int64 fixedFee;
	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct PaymentFeeData {
    FeeData sourceFee;
    FeeData destinationFee;
    bool sourcePaysForDest;    // if true source account pays fee, else destination
	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};


struct PaymentOp
{
    BalanceID sourceBalanceID;
    BalanceID destinationBalanceID;
    int64 amount;          // amount they end up with

    PaymentFeeData feeData;

    string256 subject;
    string64 reference;
    
    InvoiceReference* invoiceReference;

	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* Payment Result ********/

enum PaymentResultCode
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
    INVOICE_NOT_FOUND = -13,
    INVOICE_WRONG_AMOUNT = -14,
    INVOICE_BALANCE_MISMATCH = -15,
    INVOICE_ACCOUNT_MISMATCH = -16,
    INVOICE_ALREADY_PAID = -17
};

struct PaymentResponse {
    AccountID destination;
    uint64 paymentID;
    AssetCode asset;
    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union PaymentResult switch (PaymentResultCode code)
{
case SUCCESS:
    PaymentResponse paymentResponse;
default:
    void;
};

}
