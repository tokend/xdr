%#include "xdr/Stellar-types.h"

namespace stellar
{

struct InvestmentTokenSaleQuoteAsset
{
    AssetCode quoteAsset; // asset in which participation will be accepted
    uint64 price; // price for 1 base asset in terms of quote asset
    BalanceID quoteBalance;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    } ext;
};

struct InvestmentTokenSaleEntry
{
    uint64 saleID;
    AccountID ownerID;

    AssetCode baseAsset;
    BalanceID baseBalance;

    uint64 amountToBeSold;
    uint64 availableAmount;

    longstring details;

    InvestmentTokenSaleQuoteAsset quoteAssets<100>;

    uint64 tradingStartDate;
    uint64 settlementStartDate;
    uint64 settlementEndDate;

    AssetCode defaultRedemptionAsset;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    case ADD_PROLONGATION_FLAG_TO_ITSALE:
        bool isProlongationAllowed;
    } ext;
};

}