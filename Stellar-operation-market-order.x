// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* Creates market order, if it was not fulfilled or creation, creates regular offer

Threshold: med

Result: MarketOrderResult

*/
struct MarketOrderOp
{
    BalanceID baseBalance; // balance for base asset
	BalanceID quoteBalance; // balance for quote asset
	bool isBuy;
    int64 amount;
    uint64 orderBookID;

	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* CreateMarketOrder Result ********/

enum MarketOrderResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    MALFORMED = -1,     // generated offer would be invalid
    BALANCE_NOT_FOUND = -2,  // does not own balance for buying or selling
    UNDERFUNDED = -3,    // doesn't hold what it's trying to sell
    CROSS_SELF = -4,     // would cross an offer from the same user
	OFFER_OVERFLOW = -5,
	ASSET_PAIR_NOT_TRADABLE = -6,
	INVALID_AMOUNT = -7, // amount must be positive
	REQUIRES_VERIFICATION = -8, // source must be verified in order to participate
	REQUIRES_KYC = -9, // source must be verified in order to participate
    INVALID_INVESTMENT_TOKEN = -10,
	INCORRECT_AMOUNT_PRECISION = -11,
	ASSET_PAIR_DOES_NOT_SUPPORT_MARKET_ORDERS = -12,
    INVALID_ORDER_BOOK_ID = -13,
	ORDER_BOOK_EMPTY = -14,
	WEIGHTED_PRICE_OVERFLOW = -15 // overflow happened during price calculation
};

struct MarketOrderSuccessResult
{
    uint64 offerID; //id of regular order created afterwards
    //if 0, market order was fulfilled on creation

    // offers that got claimed
    ClaimOfferAtom offersClaimed<>;
	AssetCode baseAsset;
	AssetCode quoteAsset;

	uint64 price;

	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union MarketOrderResult switch (MarketOrderResultCode code)
{
case SUCCESS:
    MarketOrderSuccessResult success;
default:
    void;
};

}
