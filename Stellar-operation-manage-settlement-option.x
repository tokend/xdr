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
    uint64 amount;
    union switch (SettlementOptionAction action)
    {
    case PROLONG:
        void;
    case REDEEM:
        AssetCode redemptionAsset;
    }
    actionDetails;

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
    SUCCESS = 0
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
