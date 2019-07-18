
%#include "xdr/ledger-entries-sale.h"

namespace stellar
{
//: SaleCreationRequestQuoteAsset is a structure that contains an asset code with price
struct SaleCreationRequestQuoteAsset {
    //: AssetCode of quote asset
    AssetCode quoteAsset; // asset in which participation will be accepted
    //: Price of sale base asset in relation to a quote asset
    uint64 price; // price for 1 baseAsset in relation to a quote asset
    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: CreateAccountSaleRuleData is used to pass necessary params to create a new account sale rule
struct CreateAccountSaleRuleData
{
    //: Certain account for which rule is applied, null means rule is global
    AccountID* accountID;
    //: True if such rule is deniable, otherwise allows
    bool forbids;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

//: SaleCreationRequest is used to create a sale with provided parameters
struct SaleCreationRequest
{
    //: Some custom sale type that can be used while setting account rules 
    uint64 saleType;
    //: Asset code of an asset to sell on sale
    AssetCode baseAsset; // asset for which sale will be performed
    //: Asset code of an asset used to calculcate soft cap and hard cap
    AssetCode defaultQuoteAsset; // asset for soft and hard cap
    //: Time when the sale should start
    uint64 startTime; // start time of the sale
    //: Time when the sale should end
    uint64 endTime; // close time of the sale
    //: Minimal amount (in default quote asset) that has to be sold on sale for it to be considered successful
    uint64 softCap; // minimum amount of quote asset to be received at which sale will be considered a successful
    //: Maximal amount (in default quote asset) to be received during the sale. Sale closes immediately after reaching the hard cap
    uint64 hardCap; // max amount of quote asset to be received
    //: Arbitrary stringified JSON object that can be used to attach data to be reviewed by an admin
    longstring creatorDetails; // details set by requester
    //: Parameters specific to a particular sale type
    SaleTypeExt saleTypeExt;
    //:
    uint64 requiredBaseAssetForHardCap;
    //: Used to keep track of rejected requests updates. `SequenceNumber` increases after each rejected SaleCreationRequest update.
    uint32 sequenceNumber;
    //: Array of quote assets that are available for participation
    SaleCreationRequestQuoteAsset quoteAssets<100>;
    //: Use `EMPTY_VERSION` to allow anyone participate in sale,
    //: use `ADD_SALE_WHITELISTS` to specify sale participation rules
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    case ADD_SALE_WHITELISTS:
        //: array of rules that define participation rules. One global rule must be specified.
        CreateAccountSaleRuleData saleRules<>;
    }
    ext;
};

}
