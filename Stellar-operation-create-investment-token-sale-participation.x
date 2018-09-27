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
    SALE_NOT_FOUND = -2, // there is no sale with such id
    TOO_LATE = -3, // trading start date is started or available amount equals 0
    QUOTE_ASSET_NOT_FOUND = -4,
    BASE_AMOUNT_TOO_BIG = -5,
    QUOTE_BALANCE_NOT_FOUND = -6,
    FEE_OVERFLOWS = -7
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
