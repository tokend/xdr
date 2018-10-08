%#include "xdr/Stellar-ledger-entries.h"
%#include "xdr/Stellar-reviewable-request-sale.h"

namespace stellar
{

/* Processes all settlement options and non-empty investment token balances

Threshold: high

Result: PerformSettlementResult

*/

struct SettlementAsset
{
    AssetCode code;
    uint64 price;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct PerformSettlementOp
{
    uint64 investmentTokenSaleID;
    AssetCode newInvestmentToken;

    SettlementAsset settlementAssets<>;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

enum PerformSettlementResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    INVESTMENT_TOKEN_SALE_NOT_FOUND = -1,
    INVALID_NEW_INVESTMENT_TOKEN = -2,
    INVESTMENT_TOKEN_NOT_FOUND = -3,
    NEW_INVESTMENT_TOKEN_NOT_FOUND = -4,
    INVALID_SETTLEMENT_ASSETS = -5,
    SOURCE_NEW_INVESTMENT_TOKEN_BALANCE_NOT_FOUND = -6,
    ASSET_CODE_NOT_FOUND_IN_SETTLEMENT_ASSETS = -7, // some asset code from settlement options not found in settlement assets list provided by source
    SOURCE_SETTLEMENT_ASSET_BALANCE_NOT_FOUND = -8,
    SETTLEMENT_ASSET_AMOUNT_OVERFLOW = -9, // settlement asset amount for investor overflows uint64
    SOURCE_SETTLEMENT_ASSET_BALANCE_UNDERFUNDED = -10,
    INVESTOR_SETTLEMENT_ASSET_BALANCE_LINE_FULL = -11,
    TOO_EARLY_TO_PERFORM_SETTLEMENT = -12,
    NOT_ALL_SETTLEMENT_ASSETS_ARE_PROVIDED_BY_SOURCE = -13
};

struct PerformSettlementSuccess
{
   // reserved for future use
   union switch (LedgerVersion v)
   {
   case EMPTY_VERSION:
       void;
   }
   ext;
};

union PerformSettlementResult switch (PerformSettlementResultCode code)
{
case SUCCESS:
    PerformSettlementSuccess success;
default:
    void;
};

}