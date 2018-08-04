// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-types.h"

namespace stellar
{

enum WithdrawalType {
	AUTO_CONVERSION = 0
};

struct AutoConversionWithdrawalDetails {
	AssetCode destAsset; // asset in which withdrawal will be converted
	uint64 expectedAmount; // expected amount to be received in specified asset

	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct WithdrawalRequest {
	BalanceID balance; // balance id from which withdrawal will be performed
    uint64 amount; // amount to be withdrawn
    uint64 universalAmount; // amount in stats asset
	Fee fee; // expected fee to be paid
    longstring externalDetails; // details of the withdrawal (External system id, etc.)
	longstring preConfirmationDetails; // details provided by PSIM if two step withdrwal is required
	union switch (WithdrawalType withdrawalType) {
	case AUTO_CONVERSION:
		AutoConversionWithdrawalDetails autoConversion;
	} details;

	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
