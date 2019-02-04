// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-types.h"

namespace stellar
{

struct ChangeRoleRequest
{
	AccountID destinationAccount;
	uint64 accountRoleToSet;
	longstring kycData;

	// Sequence number increases when request is rejected
	uint32 sequenceNumber;

    longstring creatorDetails; // details set by requester

    // Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
