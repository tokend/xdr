%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* Creates or deletes an settlement option

Threshold: high

Result: ManageSettlementOptionResult

*/

enum ManageSettlementOptionAction
{
    CREATE = 0,
    REMOVE = 1
};

struct SettlementOptionCreationDetails
{
    uint64 investmentTokenSaleID;
    SettlementOptionDetails details;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct ManageSettlementOptionOp
{
    union switch (ManageSettlementOptionAction action)
    {
    case CREATE:
        SettlementOptionCreationDetails creationDetails;
    case REMOVE:
        uint64 settlementOptionID;
    } data;

	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageSettlementOption Result ********/

enum ManageSettlementOptionResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    SETTLEMENT_OPTION_ALREADY_EXISTS = -1,
    SETTLEMENT_OPTION_NOT_FOUND = -2, // there is no settlement option with such id
    INVESTOR_HAS_NO_INVESTMENT_TOKEN = -3,
    INVESTMENT_TOKEN_SALE_NOT_FOUND = -4, // there is no investment token sale with such id
    REDEMPTION_ASSET_NOT_FOUND = -5,
    NOW_IS_NOT_THE_SETTLEMENT_PERIOD = -6,
    INVALID_REDEMPTION_ASSET = -7,
    REDEMPTION_ASSET_IS_NOT_SUPPORTED = -8,
    PROLONGATION_IS_NOT_ALLOWED = -9
};

struct CreateSettlementOptionResponse
{
	uint64 settlementOptionID;

	union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct ManageSettlementOptionSuccess
{
    union switch (ManageSettlementOptionAction action)
    {
    case CREATE:
        CreateSettlementOptionResponse response;
    case REMOVE:
        void;
    }
    details;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union ManageSettlementOptionResult switch (ManageSettlementOptionResultCode code)
{
case SUCCESS:
    ManageSettlementOptionSuccess success;
default:
    void;
};

}
