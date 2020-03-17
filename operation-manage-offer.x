// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/ledger-entries-offer.h"

namespace stellar
{

/* Creates, updates or deletes an offer

Threshold: med

Result: ManageOfferResult

*/
//: ManageOfferOp is used to create or delete offer
struct ManageOfferOp
{
    //: Balance for base asset of an offer creator
    BalanceID baseBalance; 
    
    //: Balance for quote asset of an offer creator
    BalanceID quoteBalance; 
    
    //: Direction of an offer (to buy or to sell)
    bool isBuy;
    
    //: Amount in base asset to buy or sell (to delete an offer, set 0)
    int64 amount; 
    
    //: Price of base asset in the ratio of quote asset
    int64 price;
    
    //: Fee in quote asset to pay 
    int64 fee;
    
    //: ID of an offer to be managed. 0 to create a new offer, otherwise to edit an existing offer
    uint64 offerID;
    
    //: ID of an orderBook to put an offer in and to find a match in
    uint64 orderBookID;
     
    //: Reserved for future use
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
    //: ManageOfferOp was successfully applied
    SUCCESS = 0,
    
    // codes considered as "failure" for the operation
    //: Either the quote amount is less than the fee or the new fee is less than the old one
    MALFORMED = -1,
    //: Asset pair does not allow creating offers with it
    PAIR_NOT_TRADED = -2, 
    //: Source account of an operation does not owns one of the provided balances
    BALANCE_NOT_FOUND = -3,
    //: One of the balances does not hold the amount that it is trying to sell
    UNDERFUNDED = -4,
    //: Offer will cross with another offer of the same user 
    CROSS_SELF = -5,
    //: Overflow happened during the quote amount or fee calculation
    OFFER_OVERFLOW = -6,
    //: Either an asset pair does not exist or base and quote assets are the same
    ASSET_PAIR_NOT_TRADABLE = -7,
    //: Offer price violates the physical price restriction
    PHYSICAL_PRICE_RESTRICTION = -8,
    //: Offer price violates the current price restriction
    CURRENT_PRICE_RESTRICTION = -9,
    //: Offer with provided offerID is not found
    NOT_FOUND = -10,
    //: Negative fee is not allowed
    INVALID_PERCENT_FEE = -11,
    //: Price is too small
    INSUFFICIENT_PRICE = -12,
    //: Order book with provided ID does not exist
    ORDER_BOOK_DOES_NOT_EXISTS = -13,
    //: Sale has not started yet
    SALE_IS_NOT_STARTED_YET = -14,
    //: Sale has already ended
    SALE_ALREADY_ENDED = -15,
    //: CurrentCap of sale + offer amount will exceed the hard cap of the sale
    ORDER_VIOLATES_HARD_CAP = -16,
    //: Offer creator cannot participate in their own sale
    CANT_PARTICIPATE_OWN_SALE = -17,
    //: Sale assets and assets for specified balances are mismatched
    ASSET_MISMATCHED = -18,
    //: Sale price and offer price are mismatched
    PRICE_DOES_NOT_MATCH = -19,
    //: Price must be positive
    PRICE_IS_INVALID = -20,
    //: Offer update is not allowed
    UPDATE_IS_NOT_ALLOWED = -21,
    //: Amount must be positive
    INVALID_AMOUNT = -22,
    //: Sale is not active
    SALE_IS_NOT_ACTIVE = -23,
    //: Source must have KYC in order to participate
    REQUIRES_KYC = -24,
    //: Source account is underfunded
    SOURCE_UNDERFUNDED = -25,
    //: Overflow happened during the balance lock
    SOURCE_BALANCE_LOCK_OVERFLOW = -26,
    //: Source account must be verified in order to participate
    REQUIRES_VERIFICATION = -27,
    //: Precision set in the system and precision of the amount are mismatched
    INCORRECT_AMOUNT_PRECISION = -28,
    //: Sale specific rule forbids to participate in sale for source account
    SPECIFIC_RULE_FORBIDS = -29,
    //: Amount must be less then pending issuance
    PENDING_ISSUANCE_LESS_THEN_AMOUNT = -30
};

enum ManageOfferEffect
{
    //: Offer created 
    CREATED = 0,
    //: Offer updated
    UPDATED = 1,
    //: Offer deleted
    DELETED = 2
};

/* This result is used when offers are taken during an operation */
//: Used when offers are taken during the operation
struct ClaimOfferAtom
{
    // emitted to identify the offer
    //: ID of an account that created the matched offer
    AccountID bAccountID;
    //: ID of the matched offer
    uint64 offerID;
    //: Amount in base asset taken during the match
    int64 baseAmount;
    //: Amount in quote asset taked during the match
    int64 quoteAmount;
    //: Fee paid by an offer owner
    int64 bFeePaid;
    //: Fee paid by the source of an operation
    int64 aFeePaid;
    //: Balance in base asset of an offer owner
    BalanceID baseBalance;
    //: Balance in quote asset of an offer owner
    BalanceID quoteBalance;
    //: Match price
    int64 currentPrice;
    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};
//: Contains details of successful operation application
struct ManageOfferSuccessResult
{

    //: Offers that matched a created offer
    ClaimOfferAtom offersClaimed<>;
    //: Base asset of an offer
    AssetCode baseAsset;
    //: Quote asset of an offer
    AssetCode quoteAsset;
    
    //: Effect of operation
    union switch (ManageOfferEffect effect)
    {
    case CREATED:
    case UPDATED:
        //: Updated offer entry
        OfferEntry offer;
    default:
        void;
    }
    offer;
    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Result of `ManageOfferOp`
union ManageOfferResult switch (ManageOfferResultCode code)
{
case SUCCESS:
    ManageOfferSuccessResult success;
case PHYSICAL_PRICE_RESTRICTION:
    struct {
        //: Physical price of the base asset
        int64 physicalPrice;
        //: Reserved for future use
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        }
        ext;
    } physicalPriceRestriction;
case CURRENT_PRICE_RESTRICTION:
    struct {
        //: Current price of the base asset
        int64 currentPrice;
        //: Reserved for future use
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

