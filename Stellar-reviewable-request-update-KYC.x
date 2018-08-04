// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-types.h"

namespace stellar
{

struct UpdateKYCRequest {
	AccountID accountToUpdateKYC;
	AccountType accountTypeToSet;
	uint32 kycLevel;
	longstring kycData;

	// Tasks are represented by a bit mask. Each flag(task) in mask refers to specific KYC data validity checker
	uint32 allTasks;
	uint32 pendingTasks;

	// Sequence number increases when request is rejected
	uint32 sequenceNumber;

	// External details vector consists of comments written by KYC data validity checkers
	longstring externalDetails<>;

	// Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
