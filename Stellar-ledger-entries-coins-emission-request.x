// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-types.h"

namespace stellar
{

/* CoinsEmissionRequestEntry

    Entry representing a coins emission request.

*/
struct CoinsEmissionRequestEntry
{
	uint64 requestID;
    string64 reference;
    BalanceID receiver;
	AccountID issuer;
    int64 amount;
    AssetCode asset;
	bool isApproved;

	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};


struct CoinsEmissionEntry
{
	string64 serialNumber;
    int64 amount;
    AssetCode asset;

	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
