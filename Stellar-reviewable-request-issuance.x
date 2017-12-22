// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-types.h"

namespace stellar
{

struct PreIssuanceRequest {
	AssetCode asset;
	uint64 amount;
	DecoratedSignature signature;
	string64 reference;

	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct IssuanceRequest {
	AssetCode asset;
	uint64 amount;
	BalanceID receiver;
	longstring externalDetails; // details of the issuance (External system id, etc.)
	Fee fee; //totalFee to be payed (calculated automatically)
	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
