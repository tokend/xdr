// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* CreateWithdrawalRequestOp

    Creates withdrawal request

    Threshold: high

    Result: CreateWithdrawalRequestResult
*/

struct CreateWithdrawalRequestOp
{
    WithdrawalRequest request;

	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;

};

/******* CreateWithdrawalRequest Result ********/

enum CreateWithdrawalRequestResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
	INVALID_AMOUNT = -1, // amount is 0
    INVALID_EXTERNAL_DETAILS = -2, // external details size exceeds max allowed
	BALANCE_NOT_FOUND = -3, // balance not found
	ASSET_IS_NOT_WITHDRAWABLE = -4, // asset is not withdrawable
	CONVERSION_PRICE_IS_NOT_AVAILABLE = -5, // failed to find conversion price - conversion is not allowed
	FEE_MISMATCHED = -6, // expected fee does not match calculated fee
	CONVERSION_OVERFLOW = -7, // overflow during converting source asset to dest asset
	CONVERTED_AMOUNT_MISMATCHED = -8, // expected converted amount passed by user, does not match calculated
	BALANCE_LOCK_OVERFLOW = -9, // overflow while tried to lock amount
	UNDERFUNDED = -10, // insufficient balance to perform operation
	INVALID_UNIVERSAL_AMOUNT = -11, // non-zero universal amount
	STATS_OVERFLOW = -12, // statistics overflowed by the operation
    LIMITS_EXCEEDED = -13, // withdraw exceeds limits for source account
	INVALID_PRE_CONFIRMATION_DETAILS = -14 // it's not allowed to pass pre confirmation details
};

struct CreateWithdrawalSuccess {
	uint64 requestID;

	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};


union CreateWithdrawalRequestResult switch (CreateWithdrawalRequestResultCode code)
{
    case SUCCESS:
        CreateWithdrawalSuccess success;
    default:
        void;
};

}
