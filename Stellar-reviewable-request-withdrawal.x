// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-types.h"

namespace stellar
{

struct WithdrawalRequest {
	BalanceID balance; // balance id from which withdrawal will be performed
    uint64 amount; // amount to be withdrawn
    uint64 universalAmount; // amount in stats asset
	Fee fee; // expected fee to be paid
    longstring creatorDetails; // details set by requester

	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
