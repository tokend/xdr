// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"
%#include "xdr/Stellar-operation-manage-offer.h"

namespace stellar
{

/* CheckSaleState
Closes or cancels sale if conditions for that are met.
Threshold: med

Result: CheckSaleStateResult

*/

struct CheckSaleStateOp
{
	uint64 saleID;
	 // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;		
    }
    ext;
};

/******* CheckSaleState Result ********/

enum CheckSaleStateResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0, // sale was processed

    // codes considered as "failure" for the operation
    NOT_FOUND = -1, // sale was not found
	NOT_READY = -2 // sale is not ready to be closed or canceled
};

enum CheckSaleStateEffect {
	CANCELED = 1, // sale did not managed to go over soft cap in time
	CLOSED = 2, // sale met hard cap or (end time and soft cap)
	UPDATED = 3 // on check sale was modified and modifications must be saved
};

struct SaleCanceled {
	 // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct SaleUpdated {
	 // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct CheckSubSaleClosedResult {
	BalanceID saleBaseBalance;
	BalanceID saleQuoteBalance;
	ManageOfferSuccessResult saleDetails;
	 // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct CheckSaleClosedResult {
	AccountID saleOwner;
	CheckSubSaleClosedResult results<>;
	 // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct CheckSaleStateSuccess
{
	uint64 saleID;
	union switch (CheckSaleStateEffect effect)
    {
    case CANCELED:
        SaleCanceled saleCanceled;
	case CLOSED:
		CheckSaleClosedResult saleClosed;
	case UPDATED:
		SaleUpdated saleUpdated;
    }
    effect;
	 // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union CheckSaleStateResult switch (CheckSaleStateResultCode code)
{
case SUCCESS:
    CheckSaleStateSuccess success;
default:
    void;
};

}
