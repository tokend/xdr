// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-types.h"

namespace stellar
{

struct StatisticsEntry
{
	AccountID accountID;

	uint64 dailyOutcome;
	uint64 weeklyOutcome;
	uint64 monthlyOutcome;
	uint64 annualOutcome;

	int64 updatedAt;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}

