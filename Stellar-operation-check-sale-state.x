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
    NO_SALES_FOUND = -1 // no sales were found to meet specified conditions
};

enum CheckSaleStateEffect {
	CANCELED = 1, // sale did not managed to go over soft cap in time
	CLOSED = 2 // sale met hard cap or (end time and soft cap)
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

struct CheckSaleStateSuccess
{
	uint64 saleID;
	union switch (CheckSaleStateEffect effect)
    {
    case CANCELED:
        SaleCanceled saleCanceled;
	case CLOSED:
		ManageOfferSuccessResult saleClosed;
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
