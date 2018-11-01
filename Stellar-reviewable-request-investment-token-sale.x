%#include "xdr/Stellar-types.h"
%#include "xdr/Stellar-ledger-entries-investment-token-sale.h"
%#include "xdr/Stellar-reviewable-request-sale.h"


namespace stellar
{

struct InvestmentTokenSaleCreationRequest
{
    AssetCode baseAsset;
    uint64 amountToBeSold;
    longstring details;
    SaleCreationRequestQuoteAsset quoteAssets<100>;

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