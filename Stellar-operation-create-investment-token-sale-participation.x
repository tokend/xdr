%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* Creates new investment token sale participant

Threshold: high

Result: CreateITSaleParticipantResult

*/

struct CreateITSaleParticipationOp
{
    uint64 investmentTokenSaleID;

    BalanceID quoteBalance;
    uint64 baseAmount;

	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* CreateITSaleParticipation Result ********/

enum CreateITSaleParticipationResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    INVALID_AMOUNT = -1,
    INVESTMENT_TOKEN_SALE_NOT_FOUND = -2, // there is no investment token sale with such id
    QUOTE_ASSET_NOT_FOUND = -3,
    INSUFFICIENT_AVAILABLE_AMOUNT = -4,
    QUOTE_BALANCE_NOT_FOUND = -5,
    FEE_OVERFLOWS = -6,
    INVESTMENT_TOKEN_SALE_IS_CLOSED = -7
};


struct CreateITSaleParticipationSuccess
{
    AssetCode quoteAsset;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union CreateITSaleParticipationResult switch (CreateITSaleParticipationResultCode code)
{
case SUCCESS:
    CreateITSaleParticipationSuccess success;
default:
    void;
};

}
