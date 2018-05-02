// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-types.h"
namespace stellar
{
/* FeeEntry     
Entry representing a fee state.
*/

enum FeeType
{
    PAYMENT_FEE = 0,
	OFFER_FEE = 1,
    WITHDRAWAL_FEE = 2,
    ISSUANCE_FEE = 3
};

enum EmissionFeeType
{
	PRIMARY_MARKET = 1,
	SECONDARY_MARKET = 2
};

enum PaymentFeeType
{
    OUTGOING = 1,
    INCOMING = 2
};

struct FeeEntry
{
    FeeType feeType;
    AssetCode asset;
    int64 fixedFee; // fee paid for operation
	int64 percentFee; // percent of transfer amount to be charged

    AccountID* accountID;
    AccountType* accountType;
    int64 subtype; // for example, different withdrawals — bars or coins

    int64 lowerBound;
    int64 upperBound;

    Hash hash;

	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    case CROSS_ASSET_FEE:
        AssetCode feeAsset;
    }
    ext;
};

}
