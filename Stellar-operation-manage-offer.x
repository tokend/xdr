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
//: ManageOfferOp is used to create or delete offer
struct ManageOfferOp
{
    //: Balance for base asset of offer maker
    BalanceID baseBalance; 
    
    //: Balance for quote asset of offer maker
    BalanceID quoteBalance; 
    
    //: Direction of the offer
    bool isBuy;
    
    //: Amount in base asset to buy or sell. If set to 0 - deletes the offer
    int64 amount; 
    
    //: Price of base asset in terms of quote asset
    int64 price;
    
    //: Fee in quote asset to pay 
    int64 fee;
    
    //: ID of the offer to manage. 0 to create a new offer, otherwise edit an existing offer
    uint64 offerID;
    
    //: ID of the orderBook to find match or to put offer in.
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
    //: Quote amount is less than fee or new fee is less than old
    MALFORMED = -1,
    //: Asset pair does not allow to make offers
    PAIR_NOT_TRADED = -2, 
    //: Source account of the operation does not own one of the provided balances
    BALANCE_NOT_FOUND = -3,
    //: One of the balances does not hold the amount that its trying to sell
    UNDERFUNDED = -4,
    //: Offer would cross with another offer of the same user 
    CROSS_SELF = -5,
    //: Overflow happened during quote amount or fee calculation
    OFFER_OVERFLOW = -6,
    //: Asset pair does not allow to make offers
    ASSET_PAIR_NOT_TRADABLE = -7,
    //: Offer price violates physical price restriction
    PHYSICAL_PRICE_RESTRICTION = -8,
    //: Offer price violates current price restriction
    CURRENT_PRICE_RESTRICTION = -9,
    //: Offer with provided offerID not found
    NOT_FOUND = -10,
    //: Negative fee not allowed
    INVALID_PERCENT_FEE = -11,
    //: Price is too small
    INSUFFICIENT_PRICE = -12,
    //: Order book with provided ID does not exist
    ORDER_BOOK_DOES_NOT_EXISTS = -13,
    //: Sale has not started yet
    SALE_IS_NOT_STARTED_YET = -14,
    //: Sale has already ended
    SALE_ALREADY_ENDED = -15,
    //: CurrentCap of sale + offer amount will exceed hard cap of the sale
    ORDER_VIOLATES_HARD_CAP = -16,
    //: Can't participate in own sale
    CANT_PARTICIPATE_OWN_SALE = -17,
    //: Sale assets and assets for specified balances are mismatched
    ASSET_MISMATCHED = -18,
    //: Sale price and offer price are mismatched
    PRICE_DOES_NOT_MATCH = -19,
    //: Price must be positive
    PRICE_IS_INVALID = -20,
    //: Offer update not allowed
    UPDATE_IS_NOT_ALLOWED = -21,
    //: Amount must be positive
    INVALID_AMOUNT = -22,
    //: Sale is not active
    SALE_IS_NOT_ACTIVE = -23,
    //: Source must have KYC in order to participate
    REQUIRES_KYC = -24,
    //: Source account underfunded
    SOURCE_UNDERFUNDED = -25,
    //: Overflow happened during balance lock
    SOURCE_BALANCE_LOCK_OVERFLOW = -26,
    //: Source account must be verified in order to participate
    REQUIRES_VERIFICATION = -27,
    //: Precision set in the system and precision of the amount are mismatched
    INCORRECT_AMOUNT_PRECISION = -28
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
//: Used when offers are taked during operation
struct ClaimOfferAtom
{
    // emitted to identify the offer
    //: Address of the account that owns matched offer
    AccountID bAccountID;
    //: ID of the matched offer
    uint64 offerID;
    //: Amount in base asset taken during match
    int64 baseAmount;
    //: Amount in quote asset taked during match
    int64 quoteAmount;
    //: Fee paid by offer owner
    int64 bFeePaid;
    //: Fee paid by source of the operation
    int64 aFeePaid;
    //: Balance in base asset of offer owner
    BalanceID baseBalance;
    //: Balance in quote asset of offer owner
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

    //: Offers that got claimed while creating this offer
    ClaimOfferAtom offersClaimed<>;
    //: Base asset of the offer
    AssetCode baseAsset;
    //: Quote asset of the offer
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

//: Result of the ManageOfferOp
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

