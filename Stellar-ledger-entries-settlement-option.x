%#include "xdr/Stellar-types.h"

namespace stellar
{

enum SettlementOptionAction
{
    PROLONGATION = 1,
    REDEMPTION = 2
};

struct SettlementOptionEntry
{
    uint64 id;
    uint64 investmentTokenSaleID;

    AccountID investorID;

    union switch (SettlementOptionAction action)
    {
    case REDEMPTION:
        AssetCode asset;
    default:
        void;
    }
    details;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}