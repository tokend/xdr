// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* Creates, updates or deletes an offer

Threshold: med

Result: ManageOfferResult

*/
struct ManageOfferOp
{
    BalanceID baseBalance; // balance for base asset
	BalanceID quoteBalance; // balance for quote asset
	bool isBuy;
    int64 amount; // if set to 0, delete the offer
    int64 price;  // price of base asset in terms of quote

    int64 fee;

    // 0=create a new offer, otherwise edit an existing offer
    uint64 offerID;
	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageOffer Result ********/

enum ManageOfferResultCode
{
    // codes considered as "success" for the operation
    MANAGE_OFFER_SUCCESS = 0,

    // codes considered as "failure" for the operation
    MANAGE_OFFER_MALFORMED = -1,     // generated offer would be invalid
    MANAGE_OFFER_PAIR_NOT_TRADED = -2, // it's not allowed to trage with this pair
    MANAGE_OFFER_BALANCE_NOT_FOUND = -3,  // does not own balance for buying or selling
    MANAGE_OFFER_UNDERFUNDED = -4,    // doesn't hold what it's trying to sell
    MANAGE_OFFER_CROSS_SELF = -5,     // would cross an offer from the same user
	MANAGE_OFFER_OVERFLOW = -6,
	MANAGE_OFFER_ASSET_PAIR_NOT_TRADABLE = -7,
	MANAGE_OFFER_PHYSICAL_PRICE_RESTRICTION = -8, // offer price violates physical price restriction
	MAANGE_OFFER_CURRENT_PRICE_RESTRICTION = -9,
    MANAGE_OFFER_NOT_FOUND = -10, // offerID does not match an existing offer
    MANAGE_OFFER_INVALID_PERCENT_FEE = -11,
	MANAGE_OFFER_INSUFFISIENT_PRICE = -12
};

enum ManageOfferEffect
{
    MANAGE_OFFER_CREATED = 0,
    MANAGE_OFFER_UPDATED = 1,
    MANAGE_OFFER_DELETED = 2
};

/* This result is used when offers are taken during an operation */
struct ClaimOfferAtom
{
    // emitted to identify the offer
    AccountID bAccountID; // Account that owns the offer
    uint64 offerID;
	int64 baseAmount;
	int64 quoteAmount;
	int64 bFeePaid;
	int64 aFeePaid;
	BalanceID baseBalance;
	BalanceID quoteBalance;

	int64 currentPrice;

	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct ManageOfferSuccessResult
{

    // offers that got claimed while creating this offer
    ClaimOfferAtom offersClaimed<>;
	AssetCode baseAsset;
	AssetCode quoteAsset;

    union switch (ManageOfferEffect effect)
    {
    case MANAGE_OFFER_CREATED:
    case MANAGE_OFFER_UPDATED:
        OfferEntry offer;
    default:
        void;
    }
    offer;

	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union ManageOfferResult switch (ManageOfferResultCode code)
{
case MANAGE_OFFER_SUCCESS:
    ManageOfferSuccessResult success;
case MANAGE_OFFER_PHYSICAL_PRICE_RESTRICTION:
	struct {
		int64 physicalPrice;
		union switch (LedgerVersion v)
		{
		case EMPTY_VERSION:
			void;
		}
		ext;
	} physicalPriceRestriction;
case MAANGE_OFFER_CURRENT_PRICE_RESTRICTION:
	struct {
		int64 currentPrice;
		union switch (LedgerVersion v)
		{
		case EMPTY_VERSION:
			void;
		}
		ext;
	} currentPriceRestriction;

default:
    void;
};

}
