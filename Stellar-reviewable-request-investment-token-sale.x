%#include "xdr/Stellar-types.h"
%#include "xdr/Stellar-ledger-entries-investment-token-sale.h"

namespace stellar
{

struct InvestmentTokenSaleCreationRequestQuoteAsset
{
    AssetCode quoteAsset; // asset in which participation will be accepted
    uint64 price; // price for 1 base asset in terms of quote asset

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

struct InvestmentTokenSaleCreationRequest
{
    AssetCode baseAsset;
    uint64 amountToBeSold;
    longstring details;
    InvestmentTokenSaleCreationRequestQuoteAsset quoteAssets<100>;

    uint64 tradingStartDate;
    uint64 settlementStartDate;
    uint64 settlementEndDate;

    AssetCode defaultRedemptionAsset;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

}