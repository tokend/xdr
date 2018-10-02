%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* Processes all settlement options and non-empty investment token balances

Threshold: high

Result: PerformSettlementResult

*/

struct PerformSettlementOp
{
    uint64 investmentTokenSaleID;
    AssetCode newInvestmentToken;

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
    TRADING_PERIOD_HAS_NOT_STARTED_YET = -5, // cannot perform settlement before trading period
    SETTLEMENT_PERIOD_HAS_NOT_STARTED_YET = -6, // cannot perform settlement before settlement period
    NOW_IS_SETTLEMENT_PERIOD = -7
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